import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_event.freezed.dart';

@freezed
sealed class PortfolioEvent with _$PortfolioEvent {
  const factory PortfolioEvent.fetchRequested(String localeCode) =
      PortfolioFetchRequested;
}
