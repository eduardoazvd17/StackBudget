import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/borders.dart';
import '../utils/spacing.dart';

class AppTheme {
  late final Color materialAppColor;
  late final TextTheme _textTheme;
  late final EdgeInsets _buttonsPadding;
  late final Color _disabledColor;

  AppTheme({required bool isDarkMode}) {
    materialAppColor =
        isDarkMode
            ? AppTheme.darkScheme().surface
            : AppTheme.lightScheme().surface;
    _textTheme = _buildTextTheme(isDarkMode);
    _buttonsPadding = const EdgeInsets.symmetric(vertical: 17, horizontal: 20);
    _disabledColor = Colors.grey;
  }

  // Método factory para compatibilidade com código existente
  factory AppTheme.fromContext(BuildContext context) {
    final isDarkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    return AppTheme(isDarkMode: isDarkMode);
  }

  ThemeData light() => theme(lightScheme());
  ThemeData dark() => theme(darkScheme());

  ThemeData theme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: _textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      textButtonTheme: _textButtonTheme(colorScheme),
      outlinedButtonTheme: _outlinedButtonTheme(colorScheme),
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      appBarTheme: _appBarTheme(colorScheme),
      listTileTheme: _listTileTheme(colorScheme),
      floatingActionButtonTheme: _floatingActionButtonTheme(colorScheme),
      iconButtonTheme: _iconButtonTheme(colorScheme),
      cardTheme: _cardTheme(),
      bottomSheetTheme: _bottomSheetTheme(colorScheme),
      dialogTheme: _dialogTheme(colorScheme),
      popupMenuTheme: _popupMenuTheme(colorScheme),
      switchTheme: _switchTheme(colorScheme),
    );
  }

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1e40af),
      surfaceTint: Color(0xff1e40af),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffdbeafe),
      onPrimaryContainer: Color(0xff1e3a8a),
      secondary: Color(0xff52634f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd5e8cf),
      onSecondaryContainer: Color(0xff3b4b38),
      tertiary: Color(0xff38656a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbcebf0),
      onTertiaryContainer: Color(0xff1f4d52),
      error: Color(0xffdc2626),
      onError: Color(0xffffffff),
      errorContainer: Color(0xfffef2f2),
      onErrorContainer: Color(0xff7f1d1d),
      surface: Color(0xffffffff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff374151),
      outline: Color(0xffd1d5db),
      outlineVariant: Color(0xffe5e7eb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff111827),
      inversePrimary: Color(0xffa1d39a),
      primaryFixed: Color(0xffbcf0b4),
      onPrimaryFixed: Color(0xff002204),
      primaryFixedDim: Color(0xffa1d39a),
      onPrimaryFixedVariant: Color(0xff235024),
      secondaryFixed: Color(0xffd5e8cf),
      onSecondaryFixed: Color(0xff111f0f),
      secondaryFixedDim: Color(0xffbaccb3),
      onSecondaryFixedVariant: Color(0xff3b4b38),
      tertiaryFixed: Color(0xffbcebf0),
      onTertiaryFixed: Color(0xff002023),
      tertiaryFixedDim: Color(0xffa0cfd4),
      onTertiaryFixedVariant: Color(0xff1f4d52),
      surfaceDim: Color(0xfff9fafb),
      surfaceBright: Color(0xffffffff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9fafb),
      surfaceContainer: Color(0xfff3f4f6),
      surfaceContainerHigh: Color(0xffe5e7eb),
      surfaceContainerHighest: Color(0xffd1d5db),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff60a5fa),
      surfaceTint: Color(0xff60a5fa),
      onPrimary: Color(0xff1e3a8a),
      primaryContainer: Color(0xff1e40af),
      onPrimaryContainer: Color(0xffdbeafe),
      secondary: Color(0xffbaccb3),
      onSecondary: Color(0xff253423),
      secondaryContainer: Color(0xff3b4b38),
      onSecondaryContainer: Color(0xffd5e8cf),
      tertiary: Color(0xffa0cfd4),
      onTertiary: Color(0xff00363b),
      tertiaryContainer: Color(0xff1f4d52),
      onTertiaryContainer: Color(0xffbcebf0),
      error: Color(0xfffca5a5),
      onError: Color(0xff450a0a),
      errorContainer: Color(0xff7f1d1d),
      onErrorContainer: Color(0xfffef2f2),
      surface: Color(0xff000000),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd1d5db),
      outline: Color(0xff4b5563),
      outlineVariant: Color(0xff374151),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff9fafb),
      inversePrimary: Color(0xff3b6939),
      primaryFixed: Color(0xffbcf0b4),
      onPrimaryFixed: Color(0xff002204),
      primaryFixedDim: Color(0xffa1d39a),
      onPrimaryFixedVariant: Color(0xff235024),
      secondaryFixed: Color(0xffd5e8cf),
      onSecondaryFixed: Color(0xff111f0f),
      secondaryFixedDim: Color(0xffbaccb3),
      onSecondaryFixedVariant: Color(0xff3b4b38),
      tertiaryFixed: Color(0xffbcebf0),
      onTertiaryFixed: Color(0xff002023),
      tertiaryFixedDim: Color(0xffa0cfd4),
      onTertiaryFixedVariant: Color(0xff1f4d52),
      surfaceDim: Color(0xff000000),
      surfaceBright: Color(0xff111827),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff111827),
      surfaceContainer: Color(0xff1f2937),
      surfaceContainerHigh: Color(0xff374151),
      surfaceContainerHighest: Color(0xff4b5563),
    );
  }

  static TextTheme _buildTextTheme(bool isDarkMode) {
    const String displayFontString = 'Alatsi';
    const String bodyFontString = 'Lato';

    // Criar um tema base baseado no modo
    final baseTextTheme =
        isDarkMode ? ThemeData.dark().textTheme : ThemeData.light().textTheme;

    final TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
      bodyFontString,
      baseTextTheme,
    );
    final TextTheme displayTextTheme = GoogleFonts.getTextTheme(
      displayFontString,
      baseTextTheme,
    );
    final TextTheme textTheme = displayTextTheme.copyWith(
      bodyLarge: bodyTextTheme.bodyLarge,
      bodyMedium: bodyTextTheme.bodyMedium,
      bodySmall: bodyTextTheme.bodySmall,
      labelLarge: bodyTextTheme.labelLarge,
      labelMedium: bodyTextTheme.labelMedium,
      labelSmall: bodyTextTheme.labelSmall,
    );
    return textTheme;
  }

  SwitchThemeData _switchTheme(ColorScheme colorScheme) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return _disabledColor;
        }
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return _disabledColor.withValues(alpha: 0.3);
        }
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary.withValues(alpha: 0.3);
        }
        return colorScheme.outline.withValues(alpha: 0.3);
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary.withValues(alpha: 0.1);
        }
        return colorScheme.onSurface.withValues(alpha: 0.1);
      }),
    );
  }

  PopupMenuThemeData _popupMenuTheme(ColorScheme colorScheme) {
    return PopupMenuThemeData(
      shape: Borders.radius.medium.circularShape,
      color: colorScheme.surfaceContainerLowest,
    );
  }

  DialogThemeData _dialogTheme(ColorScheme colorScheme) {
    return DialogThemeData(
      shape: Borders.radius.medium.circularShape,
      backgroundColor: colorScheme.surface,
    );
  }

  BottomSheetThemeData _bottomSheetTheme(ColorScheme colorScheme) {
    return BottomSheetThemeData(
      backgroundColor: colorScheme.surface,
      shape: Borders.radius.medium.circularShapeTop,
    );
  }

  CardTheme _cardTheme() {
    return CardTheme(
      margin: EdgeInsets.zero,
      shape: Borders.radius.medium.circularShape,
    );
  }

  IconButtonThemeData _iconButtonTheme(ColorScheme colorScheme) {
    return const IconButtonThemeData(
      style: ButtonStyle(visualDensity: VisualDensity.compact),
    );
  }

  FloatingActionButtonThemeData _floatingActionButtonTheme(
    ColorScheme colorScheme,
  ) {
    return FloatingActionButtonThemeData(
      shape: Borders.radius.medium.circularShape,
    );
  }

  ListTileThemeData _listTileTheme(ColorScheme colorScheme) {
    return ListTileThemeData(
      contentPadding: EdgeInsets.zero,
      shape: Borders.radius.medium.circularShape,
      iconColor: colorScheme.primary,
    );
  }

  AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleSpacing: Spacing.page,
      toolbarHeight: Spacing.appBar,
      foregroundColor: colorScheme.primary,
      color: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
      shadowColor: Colors.transparent,
    );
  }

  InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      alignLabelWithHint: true,
      border: OutlineInputBorder(borderRadius: Borders.radius.medium.circular),
      filled: true,
      fillColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return _disabledColor.withValues(alpha: 0.25);
        }
        if (states.contains(WidgetState.error)) {
          return colorScheme.error.withValues(alpha: 0.05);
        }
        return colorScheme.primary.withValues(alpha: 0.1); // Default color
      }),
      disabledBorder: OutlineInputBorder(
        borderRadius: Borders.radius.medium.circular,
        borderSide: BorderSide(color: _disabledColor.withValues(alpha: 0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: Borders.radius.medium.circular,
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: Borders.radius.medium.circular,
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: Borders.radius.medium.circular,
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: Borders.radius.medium.circular,
        borderSide: BorderSide(color: colorScheme.error),
      ),
    );
  }

  ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        iconColor: colorScheme.onPrimary,
        shape: Borders.radius.medium.circularShape,
        padding: _buttonsPadding,
        disabledIconColor: _disabledColor,
        disabledForegroundColor: _disabledColor,
      ),
    );
  }

  OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.secondary,
        iconColor: colorScheme.secondary,
        shape: Borders.radius.medium.circularShape,
        padding: _buttonsPadding,
        disabledIconColor: _disabledColor,
        disabledForegroundColor: _disabledColor,
      ).copyWith(
        side: WidgetStateProperty.resolveWith<BorderSide>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(color: _disabledColor);
          }
          return BorderSide(color: colorScheme.secondary);
        }),
      ),
    );
  }

  TextButtonThemeData _textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        iconColor: colorScheme.primary,
        shape: Borders.radius.medium.circularShape,
        padding: _buttonsPadding,
        disabledIconColor: _disabledColor,
        disabledForegroundColor: _disabledColor,
      ),
    );
  }
}
