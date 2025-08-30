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

void main() async {
  AppRoutes.setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Inicializar SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    ProviderScope(
      overrides: [
        settingsDataSourceProvider.overrideWithValue(
          SettingsDataSource(prefs),
        ),
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
    
    // Carregar configurações na inicialização
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (settingsState is SettingsInitialState) {
        ref.read(settingsViewModelProvider.notifier).loadSettings();
      }
    });

    // Determinar o tema baseado nas configurações
    ThemeMode themeMode = ThemeMode.system;
    if (settingsState is SettingsLoadedState) {
      themeMode = settingsState.settings.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    }

    final currentLocale = ref.watch(localeProvider);
    
    return MaterialApp.router(
      title: 'StackBudget',
      theme: AppTheme(context).light(),
      darkTheme: AppTheme(context).dark(),
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
