import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stackbudget/firebase_options.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/settings_view_model.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/settings_view_model_state.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/locale_provider.dart';

import 'package:stackbudget/src/features/settings/data/datasources/datasources.dart';

final lightThemeProvider = Provider<ThemeData>((ref) {
  return AppTheme(isDarkMode: false).light();
});

final darkThemeProvider = Provider<ThemeData>((ref) {
  return AppTheme(isDarkMode: true).dark();
});

void main() async {
  AppRoutes.setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        settingsDataSourceProvider.overrideWithValue(SettingsDataSource(prefs)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsViewModelProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (settingsState is SettingsInitialState) {
        ref.read(settingsViewModelProvider.notifier).loadSettings();
      }
    });

    final themeMode = ref.watch(themeModeProvider);
    final lightTheme = ref.watch(lightThemeProvider);
    final darkTheme = ref.watch(darkThemeProvider);
    final currentLocale = ref.watch(localeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'StackBudget',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: currentLocale,
      scrollBehavior: CustomScrollBehavior(),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: AppRoutes.routerConfig,
      builder: (context, child) {
        return GestureDetector(
          onTap: context.closeKeyboard,
          behavior: HitTestBehavior.opaque,
          child: MediaQuery(
            data: context.mediaQuery.copyWith(
              textScaler: context.mediaQuery.textScaler.clamp(
                minScaleFactor: 0.9,
                maxScaleFactor: 1.4,
              ),
            ),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
