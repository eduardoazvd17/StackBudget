import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/auth/ui/views/widgets/auth_form.dart';

class AuthView extends ConsumerWidget {
  static const routeName = 'auth';
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthViewModelState>(authViewModelProvider, (previous, next) {
      if (next is AuthenticatedState) {
        AppRoutes.goToTransactions(context);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Spacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.area_chart,
                    size: 80,
                    color: context.colorScheme.primary,
                  ),
                  const SizedBox(height: Spacing.md),
                  Text(
                    'StackBudget',
                    style: context.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: Spacing.xs),
                  Text(
                    'Seu planejamento financeiro inteligente',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.7,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Spacing.xxl),

                  const AuthForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
