import 'package:portfolio/domain/entities/portfolio_data.dart';

abstract class PortfolioRepository {
  /// Initialise la source de données (Remote Config, etc.).
  /// À appeler une seule fois au démarrage de l'app.
  Future<void> init();

  /// Récupère les données du portfolio pour la langue donnée.
  PortfolioData fetchAll(String localeCode);
}
