class ConversionRate {
  final String fromCurrency;
  final String toCurrency;
  final double rate;
  final DateTime timestamp;

  ConversionRate({
    required this.fromCurrency,
    required this.toCurrency,
    required this.rate,
    required this.timestamp,
  });
}
