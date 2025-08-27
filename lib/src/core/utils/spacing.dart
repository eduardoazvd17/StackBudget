import 'package:flutter/material.dart';

class Spacing {
  Spacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  static const double smallest = 2.5;
  static const double small = 5;
  static const double medium = 10;
  static const double large = 15;
  static const double largest = 30;

  static const double page = 20;
  static const double page2x = 40;

  static const double safeArea = 60;
  static const double appBar = 65;
  static const double increasedAppBar = 80;
  static const double floatingButton = 120;

  static const double maxMobileWidth = 500;
  static const double maxTabletWidth = 768;
}

extension SpacingPaddingExtension on double {
  EdgeInsets get padding => EdgeInsets.all(this);
  EdgeInsets get paddingTop => EdgeInsets.only(top: this);
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: this);
  EdgeInsets get paddingLeft => EdgeInsets.only(left: this);
  EdgeInsets get paddingRight => EdgeInsets.only(right: this);
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: this);
  EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: this);
}

extension SpacingSizedBoxExtension on double {
  SizedBox get square => SizedBox(width: this, height: this);
  SizedBox get height => SizedBox(height: this);
  SizedBox get width => SizedBox(width: this);
}
