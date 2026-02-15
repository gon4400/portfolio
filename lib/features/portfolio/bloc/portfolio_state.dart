import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:portfolio/domain/entities/portfolio_data.dart';

part 'portfolio_state.freezed.dart';

@freezed
sealed class PortfolioState with _$PortfolioState {
  const factory PortfolioState.initial() = PortfolioInitial;
  const factory PortfolioState.loading() = PortfolioLoading;
  const factory PortfolioState.loaded(PortfolioData data) = PortfolioLoaded;
  const factory PortfolioState.error(String message) = PortfolioError;
}
