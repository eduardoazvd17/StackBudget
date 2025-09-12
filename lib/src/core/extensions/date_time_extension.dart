import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../enums/enums.dart';

extension DateTimeExtension on DateTime {
  String formatDateTime() {
    return DateFormat.yMd().add_Hm().format(this);
  }

  String formatDate() {
    return DateFormat.yMd().format(this);
  }

  String formatToMonthYear(BuildContext context) {
    // Para formato americano: "January 2024"
    // Para formato brasileiro: "janeiro de 2024"
    final locale = Localizations.localeOf(context);
    if (locale.languageCode == 'en') {
      return DateFormat.yMMMM().format(this);
    } else {
      return '${MonthEnum.values[month - 1].getDisplayName(context)} de $year';
    }
  }

  String formatToSimpleDate() {
    return DateFormat.Md().format(this);
  }

  DateTime getFirstDayOfMonth() {
    return DateTime(year, month, 1);
  }

  DateTime getLastDayOfMonth() {
    return DateTime(year, month + 1, 0);
  }

  String formatToDateTime() {
    return '${formatDate()} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
