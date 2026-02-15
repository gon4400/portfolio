import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:portfolio/core/locale/locale_cubit.dart';
import 'package:portfolio/core/router/app_router.dart';
import 'package:portfolio/core/theme/theme_cubit.dart';
import 'package:portfolio/utils/context_l10n.dart';
import 'package:portfolio/utils/responsive.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static const _routes = [
    AppRoutes.home,
    AppRoutes.projects,
    AppRoutes.skills,
    AppRoutes.offers,
    AppRoutes.about,
    AppRoutes.contact,
  ];

  int _locationToIndex(String location) {
    if (location.startsWith(AppRoutes.projects)) return 1;
    if (location.startsWith(AppRoutes.skills)) return 2;
    if (location.startsWith(AppRoutes.offers)) return 3;
    if (location.startsWith(AppRoutes.about)) return 4;
    if (location.startsWith(AppRoutes.contact)) return 5;
    return 0;
  }

  void _onDestinationSelected(BuildContext context, int index) =>
      context.go(_routes[index]);

  void _toggleLocale(BuildContext context) {
    final cubit = context.read<LocaleCubit>();
    final current = cubit.state ?? const Locale('fr');
    final next = current.languageCode == 'fr'
        ? const Locale('en')
        : const Locale('fr');
    cubit.setLocale(next);
  }

  void _cycleTheme(BuildContext context) {
    final cubit = context.read<ThemeCubit>();
    switch (cubit.state) {
      case ThemeMode.system:
        cubit.setMode(ThemeMode.light);
      case ThemeMode.light:
        cubit.setMode(ThemeMode.dark);
      case ThemeMode.dark:
        cubit.setMode(ThemeMode.system);
    }
  }

  IconData _themeIcon(ThemeMode mode) => switch (mode) {
        ThemeMode.light => Icons.light_mode,
        ThemeMode.dark => Icons.dark_mode,
        ThemeMode.system => Icons.brightness_auto,
      };

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);
    final l10n = context.l10n;
    final themeMode = context.watch<ThemeCubit>().state;
    final locale = context.watch<LocaleCubit>().state;
    final langCode = locale?.languageCode ?? 'fr';

    final destinations = [
      _Destination(Icons.home_outlined, Icons.home, 'Home'),
      _Destination(Icons.work_outline, Icons.work, l10n.navProjects),
      _Destination(Icons.star_outline, Icons.star, l10n.navSkills),
      _Destination(
          Icons.handshake_outlined, Icons.handshake, l10n.navOffers),
      _Destination(Icons.info_outline, Icons.info, l10n.navAbout),
      _Destination(Icons.mail_outline, Icons.mail, l10n.navContact),
    ];

    if (context.isExpanded) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: (i) =>
                  _onDestinationSelected(context, i),
              labelType: NavigationRailLabelType.all,
              leading: Column(
                children: [
                  const SizedBox(height: 8),
                  IconButton(
                    tooltip: langCode == 'fr' ? 'English' : 'Français',
                    onPressed: () => _toggleLocale(context),
                    icon: Text(
                      langCode.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.theme,
                    onPressed: () => _cycleTheme(context),
                    icon: Icon(_themeIcon(themeMode)),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              destinations: [
                for (final d in destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: Text(d.label),
                  ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    tooltip: langCode == 'fr' ? 'English' : 'Français',
                    onPressed: () => _toggleLocale(context),
                    icon: Text(
                      langCode.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.theme,
                    onPressed: () => _cycleTheme(context),
                    icon: Icon(_themeIcon(themeMode)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (i) =>
            _onDestinationSelected(context, i),
        destinations: [
          for (final d in destinations)
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selectedIcon),
              label: d.label,
            ),
        ],
      ),
    );
  }
}

class _Destination {
  const _Destination(this.icon, this.selectedIcon, this.label);

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
