import 'package:go_router/go_router.dart';

import 'package:portfolio/features/about/view/about_screen.dart';
import 'package:portfolio/features/contact/view/contact_screen.dart';
import 'package:portfolio/features/offers/view/offers_screen.dart';
import 'package:portfolio/features/portfolio/view/portfolio_screen.dart';
import 'package:portfolio/features/portfolio/view/project_detail_screen.dart';
import 'package:portfolio/features/projects/view/projects_screen.dart';
import 'package:portfolio/features/shell/view/app_shell.dart';
import 'package:portfolio/features/skills/view/skills_screen.dart';
import 'package:portfolio/features/splash/view/splash_screen.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const projects = '/projects';
  static const skills = '/skills';
  static const offers = '/offers';
  static const about = '/about';
  static const contact = '/contact';
  static const projectDetail = '/project/:id';
}

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const PortfolioScreen(),
          ),
          GoRoute(
            path: AppRoutes.projects,
            name: 'projects',
            builder: (context, state) => const ProjectsScreen(),
          ),
          GoRoute(
            path: AppRoutes.skills,
            name: 'skills',
            builder: (context, state) => const SkillsScreen(),
          ),
          GoRoute(
            path: AppRoutes.offers,
            name: 'offers',
            builder: (context, state) => const OffersScreen(),
          ),
          GoRoute(
            path: AppRoutes.about,
            name: 'about',
            builder: (context, state) => const AboutScreen(),
          ),
          GoRoute(
            path: AppRoutes.contact,
            name: 'contact',
            builder: (context, state) => const ContactScreen(),
          ),
          // Détail projet DANS le ShellRoute → la nav reste visible.
          GoRoute(
            path: AppRoutes.projectDetail,
            name: 'project-detail',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return ProjectDetailScreen(projectId: id);
            },
          ),
        ],
      ),
    ],
  );
}
