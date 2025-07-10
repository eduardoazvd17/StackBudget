import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stackbudget/firebase_options.dart';
import 'package:stackbudget/src/core/core.dart';

void main() async {
  AppRoutes.setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StackBudget',
      theme: AppTheme(context).light(),
      darkTheme: AppTheme(context).dark(),
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
