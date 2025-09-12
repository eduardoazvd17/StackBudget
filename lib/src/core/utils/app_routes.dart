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
import 'package:stackbudget/src/features/settings/ui/views/settings_view.dart';
import 'package:stackbudget/src/features/profile/ui/views/profile_view.dart';
import 'package:url_strategy/url_strategy.dart' as url;

class AppRoutes {
  AppRoutes._();

  static void setPathUrlStrategy() {
    url.setPathUrlStrategy();
    GoRouter.optionURLReflectsImperativeAPIs = true;
  }

  static final GoRouter routerConfig = GoRouter(
    initialLocation: AppRoutesConfig.transactionsPath,
    refreshListenable: _AuthStateNotifier(),
    redirect: (BuildContext context, GoRouterState state) {
      final user = FirebaseAuth.instance.currentUser;
      final isAuthRoute = state.matchedLocation == AppRoutesConfig.authPath;

      if (user == null && !isAuthRoute) {
        return AppRoutesConfig.authPath;
      }

      if (user != null && isAuthRoute) {
        return AppRoutesConfig.transactionsPath;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutesConfig.authPath,
        name: AppRoutesConfig.auth,
        builder: (context, state) => const AuthView(),
      ),

      GoRoute(
        path: AppRoutesConfig.transactionsPath,
        name: AppRoutesConfig.transactions,
        builder: (context, state) => const DashboardView(),
        routes: [
          GoRoute(
            path: AppRoutesConfig.addTransaction,
            name: AppRoutesConfig.addTransaction,
            builder: (context, state) => const AddTransactionView(),
          ),

          GoRoute(
            path: 'settings',
            name: AppRoutesConfig.settings,
            builder: (context, state) => const SettingsView(),
          ),

          GoRoute(
            path: 'profile',
            name: AppRoutesConfig.profile,
            builder: (context, state) => const ProfileView(),
          ),

          GoRoute(
            path: ':id',
            name: AppRoutesConfig.transactionDetail,
            builder: (context, state) {
              final transactionId = state.pathParameters['id']!;
              final transaction = state.extra as TransactionModel?;

              if (transaction != null) {
                return TransactionDetailView(transaction: transaction);
              } else {
                return TransactionDetailLoader(transactionId: transactionId);
              }
            },
            routes: [
              GoRoute(
                path: AppRoutesConfig.editTransaction,
                name: AppRoutesConfig.editTransaction,
                builder: (context, state) {
                  final transactionId = state.pathParameters['id']!;
                  final transaction = state.extra as TransactionModel?;

                  if (transaction != null) {
                    return EditTransactionView(transaction: transaction);
                  } else {
                    return EditTransactionLoader(transactionId: transactionId);
                  }
                },
              ),
            ],
          ),
        ],
      ),

    ],
  );

  static void goToAuth(BuildContext context) {
    context.goNamed(AppRoutesConfig.auth);
  }

  static void goToTransactions(BuildContext context) {
    context.goNamed(AppRoutesConfig.transactions);
  }

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

  static void goToSettings(BuildContext context) {
    context.goNamed(AppRoutesConfig.settings);
  }

  static void goToProfile(BuildContext context) {
    context.goNamed(AppRoutesConfig.profile);
  }

}

class _AuthStateNotifier extends ChangeNotifier {
  _AuthStateNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((_) {
      notifyListeners();
    });
  }
}
