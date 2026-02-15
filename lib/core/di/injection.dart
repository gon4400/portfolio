import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:portfolio/data/datasources/firebase_remote_config_datasource.dart';
import 'package:portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:portfolio/domain/repositories/portfolio_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ── Prefs ──
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  // ── Remote Config datasource ──
  final datasource = FirebaseRemoteConfigDatasource(
    FirebaseRemoteConfig.instance,
  );
  sl.registerSingleton<FirebaseRemoteConfigDatasource>(datasource);

  // ── Repository ──
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(datasource: sl()),
  );
}
