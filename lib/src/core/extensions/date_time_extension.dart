import 'package:flutter/material.dart';
import '../enums/enums.dart';

extension DateTimeExtension on DateTime {
  String formatDateTime() {
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    final secondStr = second.toString().padLeft(2, '0');
    return '${formatDate()} - $hourStr:$minuteStr:$secondStr';
  }

  String formatDate() {
    final dayStr = day.toString().padLeft(2, '0');
    final monthStr = month.toString().padLeft(2, '0');
    final yearStr = year.toString().padLeft(2, '0');
    return '$dayStr/$monthStr/$yearStr';
  }

  String formatToMonthYear(BuildContext context) {
    return '${MonthEnum.values[month - 1].getDisplayName(context)} de $year';
  }

  String formatToSimpleDate() {
    final dayStr = day.toString().padLeft(2, '0');
    final monthStr = month.toString().padLeft(2, '0');
    return '$dayStr/$monthStr';
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
