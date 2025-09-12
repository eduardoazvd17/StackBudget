import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stackbudget/src/core/extensions/extensions.dart';
import 'package:stackbudget/src/core/l10n/l10n.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model_state.dart';
import 'package:stackbudget/src/features/profile/ui/views/widgets/change_name_dialog.dart';
import 'package:stackbudget/src/features/profile/ui/views/widgets/change_password_dialog.dart';
import 'package:stackbudget/src/features/profile/ui/views/widgets/delete_account_dialog.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewModelProvider.notifier).loadUserProfile();
    });
  }

  void _showChangeNameDialog(String currentName) {
    showDialog<bool>(
      context: context,
      builder: (context) => ChangeNameDialog(currentName: currentName),
    ).then((result) {
      if (result == true) {
        ref.read(profileViewModelProvider.notifier).loadUserProfile();
      }
    });
  }

  void _showChangePasswordDialog() {
    showDialog<bool>(
      context: context,
      builder: (context) => const ChangePasswordDialog(),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog<bool>(
      context: context,
      builder: (context) => const DeleteAccountDialog(),
    ).then((result) {
      if (result == true && mounted) {
        context.go('/auth');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.strings;
    final state = ref.watch(profileViewModelProvider);

    ref.listen<ProfileViewModelState>(profileViewModelProvider, (
      previous,
      next,
    ) {
      if (next is ProfileAccountDeletedState) {
        context.go('/auth');
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profile), centerTitle: true),
      body: _buildBody(context, state, l10n),
    );
  }

  Widget _buildBody(
    BuildContext context,
    ProfileViewModelState state,
    AppLocalizations l10n,
  ) {
    if (state is ProfileLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ProfileErrorState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              state.exception.getMessage(context),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(profileViewModelProvider.notifier).loadUserProfile();
              },
              child: Text(l10n.retry),
            ),
          ],
        ),
      );
    }

    if (state is ProfileLoadedState ||
        state is ProfileNameUpdatedState ||
        state is ProfilePasswordUpdatedState) {
      final user =
          state is ProfileLoadedState
              ? state.user
              : state is ProfileNameUpdatedState
              ? state.updatedUser
              : (ref.read(authViewModelProvider) as AuthenticatedState).user;

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            user.name.isNotEmpty
                                ? user.name[0].toUpperCase()
                                : 'U',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              l10n.editProfile,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: const Icon(Icons.person_outline),
                title: Text(l10n.changeName),
                subtitle: Text(user.name),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showChangeNameDialog(user.name),
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: const Icon(Icons.lock_outline),
                title: Text(l10n.changePassword),
                subtitle: Text('••••••••'),
                trailing: const Icon(Icons.chevron_right),
                onTap: _showChangePasswordDialog,
              ),
            ),

            const SizedBox(height: 32),

            Text(
              l10n.deleteAccount,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.error,
              ),
            ),

            const SizedBox(height: 16),

            Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: Icon(
                  Icons.delete_forever_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  l10n.deleteAccount,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  'Esta ação não pode ser desfeita',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.error,
                ),
                onTap: _showDeleteAccountDialog,
              ),
            ),
          ],
        ),
      );
    }

    return const Center(child: CircularProgressIndicator());
  }
}
