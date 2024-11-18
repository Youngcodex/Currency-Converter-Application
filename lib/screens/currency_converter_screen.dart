import 'package:currency_converter_application/bloc/currency_state/currency_state_bloc.dart';
import 'package:currency_converter_application/main.dart';
import 'package:currency_converter_application/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CurrencyConverterScreen extends StatelessWidget {
  const CurrencyConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddCurrencyDialog(context),
          child: const Icon(Icons.add)),
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CurrencyLoaded) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 100.w,
                  child: _buildCurrencyInput(context, state),
                ),
                Expanded(
                    child: SizedBox(
                  width: 93.w,
                  child: _buildConversionsList(context, state),
                )),
              ],
            );
          }

          if (state is CurrencyError) {
            return Center(child: Text(state.message));
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildCurrencyInput(BuildContext context, CurrencyLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 70.w,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final amount = double.tryParse(value) ?? 0.0;
                context.read<CurrencyBloc>().add(UpdateAmount(amount));
              },
            ),
          ),
          // SizedBox(height: 16.0),
          SizedBox(
            // width: 20.w,
            child: DropdownButton<String>(
              value: state.baseCurrency,
              items: state.rates.keys.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (String? currency) {
                if (currency != null) {
                  context.read<CurrencyBloc>().add(
                        ChangeBaseCurrency(currency),
                      );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionsList(BuildContext context, CurrencyLoaded state) {
    return ListView.builder(
      itemCount: state.preferredCurrencies.length,
      itemBuilder: (context, index) {
        final currency = state.preferredCurrencies[index];
        final rate = state.rates[currency] ?? 0.0;
        final convertedAmount = state.amount * rate;

        return Dismissible(
          key: Key(currency),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) {
            context.read<CurrencyBloc>().add(
                  RemovePreferredCurrency(currency),
                );
          },
          child: Container(
            // height: 10,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: darkModeBoxDecoration,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currency,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      rate.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  convertedAmount.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
              // title: Text(currency),
              // trailing: Text(
              //   convertedAmount.toStringAsFixed(2),
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
            ),
          ),
        );
      },
    );
  }

  void _showAddCurrencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<CurrencyBloc, CurrencyState>(
          builder: (context, state) {
            if (state is! CurrencyLoaded) {
              return const AlertDialog(
                title: Text('Loading...'),
                content: CircularProgressIndicator(),
              );
            }

            final availableCurrencies = state.rates.keys.toList()
              ..removeWhere((currency) =>
                  state.preferredCurrencies.contains(currency) ||
                  currency == state.baseCurrency)
              ..sort();

            return AlertDialog(
              title: const Text('Add Currency'),
              content: SizedBox(
                width: double.maxFinite,
                child: availableCurrencies.isEmpty
                    ? const Center(
                        child: Text(
                          'No more currencies available to add',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: availableCurrencies.length,
                        itemBuilder: (context, index) {
                          final currency = availableCurrencies[index];
                          final rate = state.rates[currency];
                          return ListTile(
                            title: Text(currency),
                            subtitle: Text(
                              'Rate: ${rate?.toStringAsFixed(4) ?? 'N/A'}',
                            ),
                            onTap: () {
                              context.read<CurrencyBloc>().add(
                                    AddPreferredCurrency(currency),
                                  );
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
