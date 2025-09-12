import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatDateTime([String? locale]) {
    return DateFormat.yMd(locale).add_Hm().format(this);
  }

  String formatDate([String? locale]) {
    return DateFormat.yMd(locale).format(this);
  }

  String formatToMonthYear(BuildContext context) {
    // Para formato americano: "January 2024"
    // Para formato brasileiro: "janeiro de 2024"
    final locale = Localizations.localeOf(context);
    if (locale.languageCode == 'en') {
      return DateFormat.yMMMM('en_US').format(this);
    } else {
      return DateFormat.yMMMM('pt_BR').format(this);
    }
  }

  String formatToSimpleDate([String? locale]) {
    return DateFormat.Md(locale).format(this);
  }

  DateTime getFirstDayOfMonth() {
    return DateTime(year, month, 1);
  }

  DateTime getLastDayOfMonth() {
    return DateTime(year, month + 1, 0);
  }
}
