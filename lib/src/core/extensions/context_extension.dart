import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core.dart';

extension BuildContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  TextScaler get textScaler => MediaQuery.of(this).textScaler;
  double scale(double value) => textScaler.scale(value);

  AppLocalizations get strings => AppLocalizations.of(this)!;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get keyboardSize => MediaQuery.of(this).viewInsets.bottom;

  bool get isMobilePlatform =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  bool get isDesktopPlatform =>
      kIsWeb || Platform.isMacOS || Platform.isLinux || Platform.isWindows;
  bool get isMobileWidth => width <= Spacing.maxMobileWidth;
  bool get isTabletWidth => !isMobileWidth && width <= Spacing.maxTabletWidth;
  bool get isDesktopWidth => width >= Spacing.maxTabletWidth;
  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;

  void closeKeyboard() => FocusScope.of(this).unfocus();

  void pop<T>([T? result]) => Navigator.of(this).pop<T>(result);

  void navigate(String routeName, {Map<String, String> parameters = const {}}) {
    return goNamed(routeName, pathParameters: parameters);
  }

  Future<T?> showBottomSheet<T>({
    required bool isScrollControlled,
    required Widget child,
  }) async {
    return await showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      builder: (context) {
        if (isScrollControlled) {
          final double height =
              context.height -
              (MediaQuery.of(context).padding.top + kToolbarHeight);
          return SizedBox(height: height, child: child);
        }
        return child;
      },
    );
  }
}
