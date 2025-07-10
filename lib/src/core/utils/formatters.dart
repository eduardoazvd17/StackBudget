import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static String date(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }

  static String dateTime(DateTime date) {
    final hours = date.hour.toString().padLeft(2, '0');
    final minutes = date.minute.toString().padLeft(2, '0');
    final seconds = date.second.toString().padLeft(2, '0');
    return '${Formatters.date(date)} - $hours:$minutes:$seconds';
  }

  static String dates(DateTime start, DateTime end) {
    final startString = DateFormat.yMd().format(start);
    final endString = DateFormat.yMd().format(end);
    return '$startString - $endString';
  }

  static String dateRange(DateTimeRange dateRange) {
    final start = DateFormat.yMd().format(dateRange.start);
    final end = DateFormat.yMd().format(dateRange.end);
    return '$start - $end';
  }

  static double currencyToDouble(String value) {
    if (value.isEmpty) return 0;
    final doubleValue = double.tryParse(
      value.replaceAll(RegExp(r'[^0-9]'), ''),
    );
    if (doubleValue == null) return 0;
    return doubleValue / 100;
  }

  static String currency(double value, {required String currency}) {
    return NumberFormat.currency(
      symbol: currency,
      decimalDigits: 2,
    ).format(value.abs());
  }
}
