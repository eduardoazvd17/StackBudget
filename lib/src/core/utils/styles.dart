import 'package:flutter/material.dart';

import '../core.dart';

class Styles {
  Styles._();

  static ButtonStyle errorButtonStyle(BuildContext context) {
    return ButtonStyle(
      iconColor: WidgetStatePropertyAll(context.colors.error),
      foregroundColor: WidgetStatePropertyAll(context.colors.error),
      overlayColor: WidgetStatePropertyAll(
        context.colors.error.withValues(alpha: 0.05),
      ),
    );
  }

  static ButtonStyle surfaceButtonStyle(BuildContext context) {
    return ButtonStyle(
      iconColor: WidgetStatePropertyAll(context.colors.primary),
      foregroundColor: WidgetStatePropertyAll(context.colors.primary),
      backgroundColor: WidgetStatePropertyAll(context.colors.surface),
      overlayColor: WidgetStatePropertyAll(
        context.colors.primary.withValues(alpha: 0.05),
      ),
    );
  }

  static ButtonStyle secondaryButtonStyle(BuildContext context) {
    return ButtonStyle(
      iconColor: WidgetStatePropertyAll(context.colors.secondary),
      foregroundColor: WidgetStatePropertyAll(context.colors.secondary),
      overlayColor: WidgetStatePropertyAll(
        context.colors.secondary.withValues(alpha: 0.05),
      ),
    );
  }

  static ButtonStyle tertiaryButtonStyle(BuildContext context) {
    return ButtonStyle(
      iconColor: WidgetStatePropertyAll(context.colors.tertiary),
      foregroundColor: WidgetStatePropertyAll(context.colors.tertiary),
      overlayColor: WidgetStatePropertyAll(
        context.colors.tertiary.withValues(alpha: 0.05),
      ),
    );
  }

  static InputDecoration tertiaryInputDecoration(BuildContext context) {
    return InputDecoration(
      alignLabelWithHint: true,
      fillColor: context.colors.tertiary.withValues(alpha: 0.1),
      border: OutlineInputBorder(borderRadius: Borders.radius.medium.circular),
      enabledBorder: OutlineInputBorder(
        borderRadius: Borders.radius.medium.circular,
        borderSide: BorderSide(color: context.colors.tertiary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: Borders.radius.medium.circular,
        borderSide: BorderSide(color: context.colors.tertiary),
      ),
    );
  }
}
