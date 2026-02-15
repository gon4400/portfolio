import 'package:firebase_remote_config/firebase_remote_config.dart';

/// Datasource qui encapsule Firebase Remote Config.
///
/// Convention Remote Config :
///   - `portfolio_data_fr` → JSON complet du portfolio en français
///   - `portfolio_data_en` → JSON complet du portfolio en anglais
class FirebaseRemoteConfigDatasource {
  FirebaseRemoteConfigDatasource(this._rc);

  final FirebaseRemoteConfig _rc;

  /// Configure et fetch les valeurs Remote Config.
  /// À appeler **une seule fois** au démarrage.
  Future<void> init() async {
    await _rc.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await _rc.setDefaults(const {
      'portfolio_data_fr': '{}',
      'portfolio_data_en': '{}',
    });
    try {
      await _rc.fetchAndActivate();
    } catch (_) {
      // Silently use cached / default values.
    }
  }

  /// Retourne le JSON brut du portfolio pour la langue [lang] (`fr` ou `en`).
  String getPortfolioJson(String lang) =>
      _rc.getString('portfolio_data_$lang');
}
