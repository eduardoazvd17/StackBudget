import 'package:flutter/services.dart';
import 'currency_formatter.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final String currency;
  const CurrencyInputFormatter({required this.currency});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final value = double.parse(digitsOnly) / 100;

    final formattedText = CurrencyFormatter.format(value, currency);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
