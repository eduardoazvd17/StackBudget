import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double value, String currency) {
    switch (currency) {
      case 'BRL':
        return NumberFormat.currency(
          locale: 'pt_BR',
          symbol: 'R\$',
          decimalDigits: 2,
        ).format(value);
      case 'USD':
        return NumberFormat.currency(
          locale: 'en_US',
          symbol: '\$',
          decimalDigits: 2,
        ).format(value);
      case 'EUR':
        return NumberFormat.currency(
          locale: 'de_DE',
          symbol: '€',
          decimalDigits: 2,
        ).format(value);
      default:
        return NumberFormat.currency(
          locale: 'pt_BR',
          symbol: 'R\$',
          decimalDigits: 2,
        ).format(value);
    }
  }

  static String formatCompact(double value, String currency) {
    switch (currency) {
      case 'BRL':
        return NumberFormat.compactCurrency(
          locale: 'pt_BR',
          symbol: 'R\$',
          decimalDigits: 1,
        ).format(value);
      case 'USD':
        return NumberFormat.compactCurrency(
          locale: 'en_US',
          symbol: '\$',
          decimalDigits: 1,
        ).format(value);
      case 'EUR':
        return NumberFormat.compactCurrency(
          locale: 'de_DE',
          symbol: '€',
          decimalDigits: 1,
        ).format(value);
      default:
        return NumberFormat.compactCurrency(
          locale: 'pt_BR',
          symbol: 'R\$',
          decimalDigits: 1,
        ).format(value);
    }
  }

  static String getSymbol(String currency) {
    switch (currency) {
      case 'BRL':
        return 'R\$';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      default:
        return 'R\$';
    }
  }
}
