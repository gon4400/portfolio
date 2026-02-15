import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:portfolio/core/di/injection.dart';
import 'package:portfolio/core/locale/locale_cubit.dart';
import 'package:portfolio/core/router/app_router.dart';
import 'package:portfolio/domain/repositories/portfolio_repository.dart';
import 'package:portfolio/features/portfolio/bloc/portfolio_bloc.dart';
import 'package:portfolio/features/portfolio/bloc/portfolio_event.dart';
import 'package:portfolio/features/portfolio/bloc/portfolio_state.dart';
import 'package:portfolio/utils/context_l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    _initAndFetch();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Init Remote Config **une seule fois**, puis fetch les données.
  Future<void> _initAndFetch() async {
    try {
      await sl<PortfolioRepository>().init();
    } catch (_) {
      // init failure — fetchAll will return defaults.
    }
    if (!mounted) return;
    _fetch();
  }

  void _fetch() {
    final locale = context.read<LocaleCubit>().state ?? const Locale('fr');
    context
        .read<PortfolioBloc>()
        .add(PortfolioFetchRequested(locale.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<PortfolioBloc, PortfolioState>(
      listener: (context, state) {
        if (state is PortfolioLoaded) {
          context.go(AppRoutes.home);
        }
      },
      child: Scaffold(
        body: Center(
          child: FadeTransition(
            opacity: _fadeIn,
            child: BlocBuilder<PortfolioBloc, PortfolioState>(
              builder: (context, state) {
                if (state is PortfolioError) {
                  final l10n = context.l10n;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cloud_off,
                          color: colorScheme.error, size: 48),
                      const SizedBox(height: 12),
                      Text(
                        l10n.splashErrorMessage,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: _initAndFetch,
                        icon: const Icon(Icons.refresh),
                        label: Text(l10n.retry),
                      ),
                    ],
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Zenko Apps',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
