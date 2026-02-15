import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/locale/locale_cubit.dart';
import 'package:portfolio/core/widgets/error_state_widget.dart';
import 'package:portfolio/domain/entities/portfolio_data.dart';
import 'package:portfolio/features/portfolio/bloc/portfolio_bloc.dart';
import 'package:portfolio/features/portfolio/bloc/portfolio_event.dart';
import 'package:portfolio/features/portfolio/bloc/portfolio_state.dart';
import 'package:portfolio/utils/context_l10n.dart';

/// Widget générique qui gère les 3 états du [PortfolioBloc].
///
/// Remplace le pattern copié-collé dans chaque screen :
/// ```dart
/// if (state is PortfolioLoading) → loader
/// if (state is PortfolioError)   → error + retry
/// if (state is PortfolioLoaded)  → builder(data)
/// ```
class PortfolioStateBuilder extends StatelessWidget {
  const PortfolioStateBuilder({
    super.key,
    required this.title,
    required this.builder,
  });

  final String title;
  final Widget Function(BuildContext context, PortfolioData data) builder;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PortfolioBloc>().state;

    return switch (state) {
      PortfolioInitial() || PortfolioLoading() => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: const Center(child: CircularProgressIndicator()),
        ),
      PortfolioError() => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Center(
            child: ErrorStateWidget(
              message: context.l10n.loadError,
              onRetry: () => _retry(context),
              retryLabel: context.l10n.retry,
            ),
          ),
        ),
      PortfolioLoaded(:final data) => builder(context, data),
    };
  }

  void _retry(BuildContext context) {
    final locale = context.read<LocaleCubit>().state ?? const Locale('fr');
    context
        .read<PortfolioBloc>()
        .add(PortfolioFetchRequested(locale.toString()));
  }
}
