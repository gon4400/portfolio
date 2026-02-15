import 'dart:convert';
import 'dart:developer';

import 'package:portfolio/data/datasources/firebase_remote_config_datasource.dart';
import 'package:portfolio/domain/entities/portfolio_data.dart';
import 'package:portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  PortfolioRepositoryImpl({required this.datasource});

  final FirebaseRemoteConfigDatasource datasource;

  @override
  Future<void> init() => datasource.init();

  @override
  PortfolioData fetchAll(String localeCode) {
    final lang = _langOf(localeCode);
    final raw = datasource.getPortfolioJson(lang);

    if (raw.isEmpty || raw == '{}') {
      log('Remote Config: no data for lang=$lang, returning defaults');
      return const PortfolioData();
    }

    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return PortfolioData.fromJson(json);
    } catch (e, st) {
      log('Failed to parse portfolio JSON', error: e, stackTrace: st);
      return const PortfolioData();
    }
  }

  String _langOf(String localeCode) {
    final i = RegExp('[-_]').firstMatch(localeCode);
    return i == null ? localeCode : localeCode.substring(0, i.start);
  }
}
