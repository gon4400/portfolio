import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:portfolio/app/app.dart';
import 'package:portfolio/core/di/injection.dart';
import 'package:portfolio/core/locale/locale_cubit.dart';
import 'package:portfolio/core/theme/theme_cubit.dart';
import 'package:portfolio/domain/repositories/portfolio_repository.dart';
import 'package:portfolio/features/portfolio/bloc/portfolio_bloc.dart';
import 'package:portfolio/features/portfolio/bloc/recruiter_mode_cubit.dart';
import 'package:portfolio/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit(sl<SharedPreferences>())),
        BlocProvider(create: (_) => LocaleCubit(sl<SharedPreferences>())),
        BlocProvider(create: (_) => PortfolioBloc(sl<PortfolioRepository>())),
        BlocProvider(create: (_) => RecruiterModeCubit()),
      ],
      child: const PortfolioApp(),
    ),
  );
}
