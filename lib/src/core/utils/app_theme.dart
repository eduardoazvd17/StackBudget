import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../extensions/context_extension.dart';

import '../utils/borders.dart';
import '../utils/spacing.dart';

class AppTheme {
  late final Color materialAppColor;
  late final TextTheme _textTheme;
  late final EdgeInsets _buttonsPadding;
  late final Color _disabledColor;

  AppTheme(BuildContext context) {
    materialAppColor =
        context.isDarkMode
            ? AppTheme.darkScheme().surface
            : AppTheme.lightScheme().surface;
    _textTheme = _buildTextTheme(context);
    _buttonsPadding = const EdgeInsets.symmetric(vertical: 17, horizontal: 20);
    _disabledColor = Colors.grey;
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
    );
  }

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3b6939),
      surfaceTint: Color(0xff3b6939),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbcf0b4),
      onPrimaryContainer: Color(0xff235024),
      secondary: Color(0xff52634f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd5e8cf),
      onSecondaryContainer: Color(0xff3b4b38),
      tertiary: Color(0xff38656a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbcebf0),
      onTertiaryContainer: Color(0xff1f4d52),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xffF5F5F5),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff424940),
      outline: Color(0xff72796f),
      outlineVariant: Color(0xffc2c9bd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
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
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5ec),
      surfaceContainer: Color(0xffecefe6),
      surfaceContainerHigh: Color(0xffe6e9e0),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa1d39a),
      surfaceTint: Color(0xffa1d39a),
      onPrimary: Color(0xff0a390f),
      primaryContainer: Color(0xff235024),
      onPrimaryContainer: Color(0xffbcf0b4),
      secondary: Color(0xffbaccb3),
      onSecondary: Color(0xff253423),
      secondaryContainer: Color(0xff3b4b38),
      onSecondaryContainer: Color(0xffd5e8cf),
      tertiary: Color(0xffa0cfd4),
      onTertiary: Color(0xff00363b),
      tertiaryContainer: Color(0xff1f4d52),
      onTertiaryContainer: Color(0xffbcebf0),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff212121),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffc2c9bd),
      outline: Color(0xff8c9388),
      outlineVariant: Color(0xff424940),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
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
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff323630),
    );
  }

  static TextTheme _buildTextTheme(BuildContext context) {
    const String displayFontString = 'Alatsi';
    const String bodyFontString = 'Lato';

    final TextTheme baseTextTheme = context.textTheme;
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
