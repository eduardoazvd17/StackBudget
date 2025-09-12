import 'package:flutter/material.dart';

import '../extensions/extensions.dart';

enum MonthEnum {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december;

  int get value => index + 1;

  static String getNameByNumber(int monthNumber, BuildContext context) {
    final monthEnum = MonthEnum.values[monthNumber - 1];
    return monthEnum.getDisplayName(context);
  }

  static String getAbbreviationByNumber(int monthNumber, BuildContext context) {
    final monthEnum = MonthEnum.values[monthNumber - 1];
    return monthEnum.getAbbreviation(context);
  }
}

extension MonthEnumExtension on MonthEnum {
  String getDisplayName(BuildContext context) {
    switch (this) {
      case MonthEnum.january:
        return context.strings.monthJanuary;
      case MonthEnum.february:
        return context.strings.monthFebruary;
      case MonthEnum.march:
        return context.strings.monthMarch;
      case MonthEnum.april:
        return context.strings.monthApril;
      case MonthEnum.may:
        return context.strings.monthMayExt;
      case MonthEnum.june:
        return context.strings.monthJune;
      case MonthEnum.july:
        return context.strings.monthJuly;
      case MonthEnum.august:
        return context.strings.monthAugust;
      case MonthEnum.september:
        return context.strings.monthSeptember;
      case MonthEnum.october:
        return context.strings.monthOctober;
      case MonthEnum.november:
        return context.strings.monthNovember;
      case MonthEnum.december:
        return context.strings.monthDecember;
    }
  }

  String getAbbreviation(BuildContext context) {
    switch (this) {
      case MonthEnum.january:
        return context.strings.monthJan;
      case MonthEnum.february:
        return context.strings.monthFeb;
      case MonthEnum.march:
        return context.strings.monthMar;
      case MonthEnum.april:
        return context.strings.monthApr;
      case MonthEnum.may:
        return context.strings.monthMay;
      case MonthEnum.june:
        return context.strings.monthJun;
      case MonthEnum.july:
        return context.strings.monthJul;
      case MonthEnum.august:
        return context.strings.monthAug;
      case MonthEnum.september:
        return context.strings.monthSep;
      case MonthEnum.october:
        return context.strings.monthOct;
      case MonthEnum.november:
        return context.strings.monthNov;
      case MonthEnum.december:
        return context.strings.monthDec;
    }
  }
}
