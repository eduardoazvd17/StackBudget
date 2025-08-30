import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';

class DashboardHeader extends ConsumerWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    String userName = 'Usuário';
    if (authState is AuthenticatedState) {
      userName = authState.user.name;
    }

    return Container(
      padding: const EdgeInsets.all(Spacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: Spacing.xs),
                Text(
                  userName,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          // Menu de opções
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: context.colorScheme.onSurface),
            onSelected: (value) async {
              switch (value) {
                case 'logout':
                  _showLogoutConfirmation(context, ref);
                  break;
                case 'profile':
                  // TODO: Navegar para perfil
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.profileComingSoon)),
                  );
                  break;
                case 'settings':
                  AppRoutes.goToSettings(context);
                  break;
              }
            },
            itemBuilder:
                (context) => [
                                        PopupMenuItem(
                        value: 'profile',
                        child: ListTile(
                          leading: Icon(Icons.person_outline),
                          title: Text(AppLocalizations.of(context)!.profile),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                                        PopupMenuItem(
                        value: 'settings',
                        child: ListTile(
                          leading: Icon(Icons.settings_outlined),
                          title: Text(AppLocalizations.of(context)!.settings),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                  const PopupMenuDivider(),
                                      PopupMenuItem(
                      value: 'logout',
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text(AppLocalizations.of(context)!.logout),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                ],
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Bom dia!';
    } else if (hour < 18) {
      return 'Boa tarde!';
    } else {
      return 'Boa noite!';
    }
  }

  void _showLogoutConfirmation(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.confirmLogout),
                          content: Text(AppLocalizations.of(context)!.confirmLogoutMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              FilledButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await ref.read(authViewModelProvider.notifier).signOut();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text(AppLocalizations.of(context)!.logout),
              ),
            ],
          ),
    );
  }
}
