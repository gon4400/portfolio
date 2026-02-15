import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:portfolio/domain/repositories/portfolio_repository.dart';
import 'package:portfolio/features/portfolio/bloc/portfolio_event.dart';
import 'package:portfolio/features/portfolio/bloc/portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc(this._repository) : super(const PortfolioState.initial()) {
    on<PortfolioFetchRequested>(_onFetch);
  }

  final PortfolioRepository _repository;

  Future<void> _onFetch(
    PortfolioFetchRequested event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(const PortfolioState.loading());
    try {
      final data = _repository.fetchAll(event.localeCode);
      emit(PortfolioState.loaded(data));
    } catch (e) {
      emit(PortfolioState.error(e.toString()));
    }
  }
}
