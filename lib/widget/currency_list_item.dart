import 'package:flutter/material.dart';

class CurrencyListItem extends StatelessWidget {
  final String currencyCode;
  final double? rate;
  final VoidCallback onTap;

  const CurrencyListItem({
    Key? key,
    required this.currencyCode,
    required this.rate,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Currency code with optional flag emoji
              Text(
                '$currencyCode',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              // Exchange rate
              Text(
                'Rate: ${rate?.toStringAsFixed(4) ?? 'N/A'}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
