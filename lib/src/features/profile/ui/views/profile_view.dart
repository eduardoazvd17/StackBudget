import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stackbudget/src/core/extensions/extensions.dart';
import 'package:stackbudget/src/core/l10n/l10n.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model_state.dart';
import 'package:stackbudget/src/features/profile/ui/views/widgets/change_name_dialog.dart'
    as change_name;
import 'package:stackbudget/src/features/profile/ui/views/widgets/change_password_dialog.dart'
    as change_password;
import 'package:stackbudget/src/features/profile/ui/views/widgets/delete_account_dialog.dart'
    as delete_account;

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

  void _showChangeNameBottomSheet(String currentName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) =>
              change_name.ChangeNameBottomSheet(currentName: currentName),
    );
  }

  void _showChangePasswordBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const change_password.ChangePasswordBottomSheet(),
    );
  }

  void _showDeleteAccountBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const delete_account.DeleteAccountBottomSheet(),
    );
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
        state is ProfilePasswordUpdatedState ||
        state is ProfileErrorState) {
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? const Color(
                                  0xff1e40af,
                                ) // Azul mais intenso para dark mode
                                : Theme.of(
                                  context,
                                ).primaryColor, // Cor primária para light mode
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
                              style: Theme.of(context).textTheme.headlineSmall,
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
                onTap: () => _showChangeNameBottomSheet(user.name),
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
                onTap: _showChangePasswordBottomSheet,
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
                  l10n.actionCannotBeUndone,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.error,
                ),
                onTap: _showDeleteAccountBottomSheet,
              ),
            ),
          ],
        ),
      );
    }

    return const Center(child: CircularProgressIndicator());
  }
}
