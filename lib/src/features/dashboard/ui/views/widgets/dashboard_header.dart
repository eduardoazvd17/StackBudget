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

    String userName = context.strings.defaultUserName;
    String greetingMessage = _getGreetingMessage(context);
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
                  greetingMessage,
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
            icon: Icon(Icons.more_horiz, color: context.colorScheme.onSurface),
            onSelected: (value) async {
              switch (value) {
                case 'logout':
                  _showLogoutConfirmation(context, ref);
                  break;
                case 'profile':
                  AppRoutes.goToProfile(context);
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
                      title: Text(context.strings.profile),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  PopupMenuItem(
                    value: 'settings',
                    child: ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text(context.strings.settings),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'logout',
                    child: ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        context.strings.logout,
                        style: TextStyle(color: Colors.red),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
          ),
        ],
      ),
    );
  }

  String _getGreetingMessage(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return context.strings.goodMorning;
    } else if (hour < 18) {
      return context.strings.goodAfternoon;
    } else {
      return context.strings.goodEvening;
    }
  }

  void _showLogoutConfirmation(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(context.strings.confirmLogout),
            content: Text(context.strings.confirmLogoutMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.strings.cancel),
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
                child: Text(context.strings.logout),
              ),
            ],
          ),
    );
  }
}
