import 'package:currency_converter_application/bloc/currency_state/currency_state_bloc.dart';
import 'package:currency_converter_application/repository/currency_repository.dart';
import 'package:currency_converter_application/screens/currency_converter_screen.dart';
import 'package:currency_converter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final prefs = await SharedPreferences.getInstance();
  final repository = CurrencyRepository(prefs);
  runApp(MyApp(
    repository: repository,
  ));
}

class MyApp extends StatelessWidget {
  final CurrencyRepository repository;

  const MyApp({super.key, required this.repository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyBloc(repository)..add(LoadCurrencies()),
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Currency Converter',
          theme: themeData,
          home: const CurrencyConverterScreen(),
        );
      }),
    );
  }
}
