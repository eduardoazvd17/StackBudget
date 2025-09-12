import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/ui/view_models/currency_provider.dart';
import '../utils/currency_formatter.dart';

extension WidgetRefExtension on WidgetRef {
  String formatCurrency(double value) {
    final currency = watch(currencyProvider);
    return CurrencyFormatter.format(value, currency);
  }
}
