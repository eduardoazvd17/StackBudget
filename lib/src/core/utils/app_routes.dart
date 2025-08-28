import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stackbudget/src/core/utils/app_routes_config.dart';
import 'package:stackbudget/src/features/auth/ui/views/auth_view.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/dashboard_view.dart';
import 'package:stackbudget/src/features/transactions/ui/views/add_transaction_view.dart';
import 'package:stackbudget/src/features/transactions/ui/views/transaction_detail_view.dart';
import 'package:stackbudget/src/features/transactions/ui/views/edit_transaction_view.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
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
          // Rota para adicionar transação
          GoRoute(
            path: 'add-transaction',
            name: AppRoutesConfig.addTransaction,
            builder: (context, state) => const AddTransactionView(),
          ),

          // Rota para detalhes da transação
          GoRoute(
            path: 'transaction-detail',
            name: AppRoutesConfig.transactionDetail,
            builder: (context, state) {
              final transaction = state.extra as TransactionModel;
              return TransactionDetailView(transaction: transaction);
            },
          ),

          // Rota para editar transação
          GoRoute(
            path: 'edit-transaction',
            name: AppRoutesConfig.editTransaction,
            builder: (context, state) {
              final transaction = state.extra as TransactionModel;
              return EditTransactionView(transaction: transaction);
            },
          ),

          // Futuras sub-rotas:
          // GoRoute(
          //   path: 'transactions',
          //   name: AppRoutesConfig.transactions,
          //   builder: (context, state) => const TransactionsView(),
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

  // Métodos de navegação implementados
  static void goToAddTransaction(BuildContext context) {
    context.goNamed(AppRoutesConfig.addTransaction);
  }

  static void goToTransactionDetail(
    BuildContext context,
    TransactionModel transaction,
  ) {
    context.goNamed(AppRoutesConfig.transactionDetail, extra: transaction);
  }

  static void goToEditTransaction(
    BuildContext context,
    TransactionModel transaction,
  ) {
    context.goNamed(AppRoutesConfig.editTransaction, extra: transaction);
  }

  // Futuros métodos de navegação
  // static void goToTransactions(BuildContext context) {
  //   context.goNamed(AppRoutesConfig.transactions);
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
