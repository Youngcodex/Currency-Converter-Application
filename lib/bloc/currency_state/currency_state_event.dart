part of 'currency_state_bloc.dart';

@immutable
sealed class CurrencyEvent {}

class LoadCurrencies extends CurrencyEvent {}

class UpdateAmount extends CurrencyEvent {
  final double amount;
  UpdateAmount(this.amount);
}

class ChangeBaseCurrency extends CurrencyEvent {
  final String currency;
  ChangeBaseCurrency(this.currency);
}

class AddPreferredCurrency extends CurrencyEvent {
  final String currency;
  AddPreferredCurrency(this.currency);
}

class RemovePreferredCurrency extends CurrencyEvent {
  final String currency;
  RemovePreferredCurrency(this.currency);
}
