part of 'currency_state_bloc.dart';

@immutable
sealed class CurrencyState {}

final class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final Map<String, double> rates;
  final List<String> preferredCurrencies;
  final double amount;
  final String baseCurrency;

  CurrencyLoaded({
    required this.rates,
    required this.preferredCurrencies,
    required this.amount,
    required this.baseCurrency,
  });
}

class CurrencyError extends CurrencyState {
  final String message;
  CurrencyError(this.message);
}
