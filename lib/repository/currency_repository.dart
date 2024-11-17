import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyRepository {
  final Dio _dio = Dio();
  final SharedPreferences _prefs;
  static const String API_KEY = 'YOUR_API_KEY'; // Replace with your API key
  static const String BASE_URL = 'https://api.exchangerate-api.com/v4/latest/';
  static const String PREFERRED_CURRENCIES_KEY = 'preferred_currencies';

  CurrencyRepository(this._prefs);

  Future<Map<String, double>> getExchangeRates(String baseCurrency) async {
    try {
      final response = await _dio.get('$BASE_URL$baseCurrency');
      return Map<String, double>.from(response.data['rates']);
    } catch (e) {
      throw Exception('Failed to fetch exchange rates');
    }
  }

  Future<List<String>> getPreferredCurrencies() async {
    final currencies = _prefs.getStringList(PREFERRED_CURRENCIES_KEY);
    return currencies ?? ['EUR', 'USD', 'GBP']; // Default currencies
  }

  Future<void> savePreferredCurrencies(List<String> currencies) async {
    await _prefs.setStringList(PREFERRED_CURRENCIES_KEY, currencies);
  }

  Future<void> addPreferredCurrency(String currency) async {
    final currencies = await getPreferredCurrencies();
    if (!currencies.contains(currency)) {
      currencies.add(currency);
      await savePreferredCurrencies(currencies);
    }
  }

  Future<void> removePreferredCurrency(String currency) async {
    final currencies = await getPreferredCurrencies();
    currencies.remove(currency);
    await savePreferredCurrencies(currencies);
  }
}
