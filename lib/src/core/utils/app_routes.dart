import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stackbudget/src/core/utils/app_routes_config.dart';
import 'package:stackbudget/src/features/auth/ui/views/auth_view.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/dashboard_view.dart';
import 'package:url_strategy/url_strategy.dart' as url;

class AppRoutes {
  AppRoutes._();

  static void setPathUrlStrategy() {
    url.setPathUrlStrategy();
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  static final GoRouter routerConfig = GoRouter(
    initialLocation: AppRoutesConfig.homePath,
    redirect: (BuildContext context, GoRouterState state) {
      final user = FirebaseAuth.instance.currentUser;
      final isAuthRoute = state.matchedLocation == AppRoutesConfig.authPath;

      // Se não está autenticado e não está na tela de auth, redireciona para auth
      if (user == null && !isAuthRoute) {
        return AppRoutesConfig.authPath;
      }

      // Se está autenticado e está na tela de auth, redireciona para home
      if (user != null && isAuthRoute) {
        return AppRoutesConfig.homePath;
      }

      // Caso contrário, mantém na rota atual
      return null;
    },
    routes: [
      // Rota de Autenticação
      GoRoute(
        path: AppRoutesConfig.authPath,
        name: AppRoutesConfig.auth,
        builder: (context, state) => const AuthView(),
      ),

      // Rota Principal (Dashboard)
      GoRoute(
        path: AppRoutesConfig.homePath,
        name: AppRoutesConfig.home,
        builder: (context, state) => const DashboardView(),
        routes: [
          // Futuras sub-rotas serão adicionadas aqui conforme implementamos:
          //
          // GoRoute(
          //   path: 'transactions',
          //   name: AppRoutesConfig.transactions,
          //   builder: (context, state) => const TransactionsView(),
          //   routes: [
          //     GoRoute(
          //       path: 'add',
          //       name: AppRoutesConfig.addTransaction,
          //       builder: (context, state) => const AddTransactionView(),
          //     ),
          //     GoRoute(
          //       path: 'edit/:id',
          //       name: AppRoutesConfig.editTransaction,
          //       builder: (context, state) => EditTransactionView(
          //         transactionId: state.pathParameters['id']!,
          //       ),
          //     ),
          //   ],
          // ),
          //
          // GoRoute(
          //   path: 'budget',
          //   name: AppRoutesConfig.budget,
          //   builder: (context, state) => const BudgetView(),
          // ),
          //
          // GoRoute(
          //   path: 'reports',
          //   name: AppRoutesConfig.reports,
          //   builder: (context, state) => const ReportsView(),
          // ),
          //
          // GoRoute(
          //   path: 'settings',
          //   name: AppRoutesConfig.settings,
          //   builder: (context, state) => const SettingsView(),
          // ),
        ],
      ),
    ],
  );

  // Métodos auxiliares para navegação
  static void goToAuth(BuildContext context) {
    context.goNamed(AppRoutesConfig.auth);
  }

  static void goToHome(BuildContext context) {
    context.goNamed(AppRoutesConfig.home);
  }

  // Futuros métodos de navegação
  // static void goToTransactions(BuildContext context) {
  //   context.goNamed(AppRoutesConfig.transactions);
  // }
  //
  // static void goToAddTransaction(BuildContext context) {
  //   context.goNamed(AppRoutesConfig.addTransaction);
  // }
  //
  // static void goToBudget(BuildContext context) {
  //   context.goNamed(AppRoutesConfig.budget);
  // }
  //
  // static void goToReports(BuildContext context) {
  //   context.goNamed(AppRoutesConfig.reports);
  // }
  //
  // static void goToSettings(BuildContext context) {
  //   context.goNamed(AppRoutesConfig.settings);
  // }
}
