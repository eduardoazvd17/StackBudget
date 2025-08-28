import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stackbudget/src/core/utils/app_routes_config.dart';
import 'package:stackbudget/src/features/auth/ui/views/auth_view.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/dashboard_view.dart';
import 'package:stackbudget/src/features/transactions/ui/views/add_transaction_view.dart';
import 'package:stackbudget/src/features/transactions/ui/views/transaction_detail_view.dart';
import 'package:stackbudget/src/features/transactions/ui/views/edit_transaction_view.dart';
import 'package:stackbudget/src/features/transactions/ui/views/transaction_detail_loader.dart';
import 'package:stackbudget/src/features/transactions/ui/views/edit_transaction_loader.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:url_strategy/url_strategy.dart' as url;

class AppRoutes {
  AppRoutes._();

  static void setPathUrlStrategy() {
    url.setPathUrlStrategy();
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  static final GoRouter routerConfig = GoRouter(
    initialLocation: AppRoutesConfig.transactionsPath,
    redirect: (BuildContext context, GoRouterState state) {
      final user = FirebaseAuth.instance.currentUser;
      final isAuthRoute = state.matchedLocation == AppRoutesConfig.authPath;

      // Se não está autenticado e não está na tela de auth, redireciona para auth
      if (user == null && !isAuthRoute) {
        return AppRoutesConfig.authPath;
      }

      // Se está autenticado e está na tela de auth, redireciona para transactions
      if (user != null && isAuthRoute) {
        return AppRoutesConfig.transactionsPath;
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

      // Rota Principal (Transactions/Dashboard)
      GoRoute(
        path: AppRoutesConfig.transactionsPath,
        name: AppRoutesConfig.transactions,
        builder: (context, state) => const DashboardView(),
        routes: [
          // Rota para adicionar transação: /transactions/add
          GoRoute(
            path: AppRoutesConfig.addTransaction,
            name: AppRoutesConfig.addTransaction,
            builder: (context, state) => const AddTransactionView(),
          ),

          // Rota para detalhes da transação: /transactions/:id
          GoRoute(
            path: ':id',
            name: AppRoutesConfig.transactionDetail,
            builder: (context, state) {
              final transactionId = state.pathParameters['id']!;
              final transaction = state.extra as TransactionModel?;

              if (transaction != null) {
                return TransactionDetailView(transaction: transaction);
              } else {
                // Se não tem o objeto, precisa buscar pelo ID
                return TransactionDetailLoader(transactionId: transactionId);
              }
            },
            routes: [
              // Rota para editar transação: /transactions/:id/edit
              GoRoute(
                path: AppRoutesConfig.editTransaction,
                name: AppRoutesConfig.editTransaction,
                builder: (context, state) {
                  final transactionId = state.pathParameters['id']!;
                  final transaction = state.extra as TransactionModel?;

                  if (transaction != null) {
                    return EditTransactionView(transaction: transaction);
                  } else {
                    // Se não tem o objeto, precisa buscar pelo ID
                    return EditTransactionLoader(transactionId: transactionId);
                  }
                },
              ),
            ],
          ),
        ],
      ),

      // Futuras rotas principais
      // GoRoute(
      //   path: AppRoutesConfig.budgetPath,
      //   name: AppRoutesConfig.budget,
      //   builder: (context, state) => const BudgetView(),
      // ),
      //
      // GoRoute(
      //   path: AppRoutesConfig.profilePath,
      //   name: AppRoutesConfig.profile,
      //   builder: (context, state) => const ProfileView(),
      // ),
    ],
  );

  // Métodos auxiliares para navegação
  static void goToAuth(BuildContext context) {
    context.goNamed(AppRoutesConfig.auth);
  }

  static void goToTransactions(BuildContext context) {
    context.goNamed(AppRoutesConfig.transactions);
  }

  // Métodos de navegação implementados
  static void goToAddTransaction(BuildContext context) {
    context.goNamed(AppRoutesConfig.addTransaction);
  }

  static void goToTransactionDetail(
    BuildContext context,
    TransactionModel transaction,
  ) {
    context.goNamed(
      AppRoutesConfig.transactionDetail,
      pathParameters: {'id': transaction.id},
      extra: transaction,
    );
  }

  static void goToTransactionDetailById(
    BuildContext context,
    String transactionId,
  ) {
    context.goNamed(
      AppRoutesConfig.transactionDetail,
      pathParameters: {'id': transactionId},
    );
  }

  static void goToEditTransaction(
    BuildContext context,
    TransactionModel transaction,
  ) {
    context.goNamed(
      AppRoutesConfig.editTransaction,
      pathParameters: {'id': transaction.id},
      extra: transaction,
    );
  }

  static void goToEditTransactionById(
    BuildContext context,
    String transactionId,
  ) {
    context.goNamed(
      AppRoutesConfig.editTransaction,
      pathParameters: {'id': transactionId},
    );
  }

  // Futuros métodos de navegação
  // static void goToBudget(BuildContext context) {
  //   context.goNamed(AppRoutesConfig.budget);
  // }
  //
  // static void goToReports(BuildContext context) {
  //   context.goNamed(AppRoutesConfig.reports);
  // }
}
