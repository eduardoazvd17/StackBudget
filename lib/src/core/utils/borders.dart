import 'package:flutter/material.dart';

class Borders {
  Borders._();
  static const sizes = SizeValues();
  static const radius = RadiusValues();
}

class SizeValues {
  const SizeValues();
  final double small = 1;
  final double medium = 2;
  final double large = 3;
}

class RadiusValues {
  const RadiusValues();
  final double none = 0;
  final double small = 5;
  final double medium = 10;
  final double large = 15;
  final double large2x = 30;
}

extension BorderRadiusExtension on double {
  BorderRadius get circular => BorderRadius.circular(this);
  BorderRadius get circularTop => BorderRadius.only(
    topLeft: Radius.circular(this),
    topRight: Radius.circular(this),
  );
  BorderRadius get circularBottom => BorderRadius.only(
    bottomLeft: Radius.circular(this),
    bottomRight: Radius.circular(this),
  );
  BorderRadius get circularLeft => BorderRadius.only(
    topLeft: Radius.circular(this),
    bottomLeft: Radius.circular(this),
  );
  BorderRadius get circularRight => BorderRadius.only(
    topRight: Radius.circular(this),
    bottomRight: Radius.circular(this),
  );

  RoundedRectangleBorder get circularShape =>
      RoundedRectangleBorder(borderRadius: circular);
  RoundedRectangleBorder get circularShapeTop =>
      RoundedRectangleBorder(borderRadius: circularTop);
  RoundedRectangleBorder get circularShapeBottom =>
      RoundedRectangleBorder(borderRadius: circularBottom);
  RoundedRectangleBorder get circularShapeLeft =>
      RoundedRectangleBorder(borderRadius: circularLeft);
  RoundedRectangleBorder get circularShapeRight =>
      RoundedRectangleBorder(borderRadius: circularRight);
}
