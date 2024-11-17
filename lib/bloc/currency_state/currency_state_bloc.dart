import 'package:bloc/bloc.dart';
import 'package:currency_converter_application/repository/currency_repository.dart';
import 'package:meta/meta.dart';

part 'currency_state_event.dart';
part 'currency_state_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository repository;
  double _currentAmount = 1.0;
  String _currentBaseCurrency = 'USD';
  Map<String, double> _currentRates = {};

  CurrencyBloc(this.repository) : super(CurrencyInitial()) {
    on<LoadCurrencies>(_onLoadCurrencies);
    on<UpdateAmount>(_onUpdateAmount);
    on<ChangeBaseCurrency>(_onChangeBaseCurrency);
    on<AddPreferredCurrency>(_onAddPreferredCurrency);
    on<RemovePreferredCurrency>(_onRemovePreferredCurrency);
  }

  Future<void> _onLoadCurrencies(
    LoadCurrencies event,
    Emitter<CurrencyState> emit,
  ) async {
    try {
      emit(CurrencyLoading());
      final preferredCurrencies = await repository.getPreferredCurrencies();
      final rates = await repository.getExchangeRates(_currentBaseCurrency);
      _currentRates = rates;
      emit(CurrencyLoaded(
        rates: rates,
        preferredCurrencies: preferredCurrencies,
        amount: _currentAmount,
        baseCurrency: _currentBaseCurrency,
      ));
    } catch (e) {
      emit(CurrencyError(e.toString()));
    }
  }

  Future<void> _onUpdateAmount(
    UpdateAmount event,
    Emitter<CurrencyState> emit,
  ) async {
    if (state is CurrencyLoaded) {
      final currentState = state as CurrencyLoaded;
      _currentAmount = event.amount;
      emit(CurrencyLoaded(
        rates: currentState.rates,
        preferredCurrencies: currentState.preferredCurrencies,
        amount: event.amount,
        baseCurrency: currentState.baseCurrency,
      ));
    }
  }

  Future<void> _onChangeBaseCurrency(
    ChangeBaseCurrency event,
    Emitter<CurrencyState> emit,
  ) async {
    try {
      if (state is CurrencyLoaded) {
        final currentState = state as CurrencyLoaded;
        emit(CurrencyLoading());

        _currentBaseCurrency = event.currency;
        final rates = await repository.getExchangeRates(event.currency);
        _currentRates = rates;

        emit(CurrencyLoaded(
          rates: rates,
          preferredCurrencies: currentState.preferredCurrencies,
          amount: _currentAmount,
          baseCurrency: event.currency,
        ));
      }
    } catch (e) {
      emit(CurrencyError(e.toString()));
    }
  }

  Future<void> _onAddPreferredCurrency(
    AddPreferredCurrency event,
    Emitter<CurrencyState> emit,
  ) async {
    if (state is CurrencyLoaded) {
      final currentState = state as CurrencyLoaded;
      await repository.addPreferredCurrency(event.currency);
      final updatedCurrencies = await repository.getPreferredCurrencies();

      emit(CurrencyLoaded(
        rates: currentState.rates,
        preferredCurrencies: updatedCurrencies,
        amount: _currentAmount,
        baseCurrency: currentState.baseCurrency,
      ));
    }
  }

  Future<void> _onRemovePreferredCurrency(
    RemovePreferredCurrency event,
    Emitter<CurrencyState> emit,
  ) async {
    if (state is CurrencyLoaded) {
      final currentState = state as CurrencyLoaded;
      await repository.removePreferredCurrency(event.currency);
      final updatedCurrencies = await repository.getPreferredCurrencies();

      emit(CurrencyLoaded(
        rates: currentState.rates,
        preferredCurrencies: updatedCurrencies,
        amount: _currentAmount,
        baseCurrency: currentState.baseCurrency,
      ));
    }
  }
}
