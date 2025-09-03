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
    // Remove tudo exceto dígitos
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Converte para double (centavos para reais)
    final value = double.parse(digitsOnly) / 100;

    // Formata usando o CurrencyFormatter
    final formattedText = CurrencyFormatter.format(value, currency);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
