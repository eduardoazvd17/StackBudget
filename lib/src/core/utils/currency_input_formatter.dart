import 'package:flutter/services.dart';

import 'utils.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final String currency;
  const CurrencyInputFormatter({required this.currency});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final value = double.tryParse(newValue.text) ?? 0.0;
    final formattedText = Formatters.currency(value / 100, currency: currency);
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
