import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyRepository {
  final Dio _dio = Dio();
  final SharedPreferences _prefs;
  static String API_KEY =
      '${dotenv.env['Exchange_Rate_Api']}'; // Replace with your API key
  static String BASE_URL =
      'https://v6.exchangerate-api.com/v6/${API_KEY}/latest/';
  static const String PREFERRED_CURRENCIES_KEY = 'preferred_currencies';

  CurrencyRepository(this._prefs);

  Future<Map<String, dynamic>> getExchangeRates(String baseCurrency) async {
    try {
      final response = await _dio.get('$BASE_URL$baseCurrency');
      print(response.data['conversion_rates'].runtimeType);
      return Map<String, dynamic>.from(response.data['conversion_rates']);
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch exchange rates');
    }
  }

  Future<List<String>> getPreferredCurrencies() async {
    final currencies = _prefs.getStringList(PREFERRED_CURRENCIES_KEY);
    return currencies ?? []; // Default currencies
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
