import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/extensions/extensions.dart';
import 'package:stackbudget/src/core/utils/utils.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model_state.dart';

class ChangePasswordDialog extends ConsumerStatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  ConsumerState<ChangePasswordDialog> createState() =>
      _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends ConsumerState<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _getErrorMessage(String key) {
    final l10n = context.strings;
    switch (key) {
      case 'currentPasswordRequired':
        return l10n.currentPasswordRequired;
      case 'newPasswordRequired':
        return l10n.newPasswordRequired;
      case 'confirmPasswordRequired':
        return l10n.confirmPasswordRequired;
      case 'passwordTooWeak':
        return l10n.passwordTooWeak;
      case 'passwordsDoNotMatch':
        return l10n.passwordsDoNotMatch;
      default:
        return key;
    }
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    await ref
        .read(profileViewModelProvider.notifier)
        .updatePassword(
          _currentPasswordController.text,
          _newPasswordController.text,
        );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.strings;

    ref.listen<ProfileViewModelState>(profileViewModelProvider, (
      previous,
      next,
    ) {
      if (next is ProfilePasswordUpdatedState) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.passwordUpdatedSuccess),
            backgroundColor: Colors.green,
          ),
        );
      } else if (next is ProfileErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.exception.getMessage(context)),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return AlertDialog(
      title: Text(l10n.changePassword),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _currentPasswordController,
              decoration: InputDecoration(
                labelText: l10n.currentPassword,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showCurrentPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _showCurrentPassword = !_showCurrentPassword;
                    });
                  },
                ),
              ),
              obscureText: !_showCurrentPassword,
              validator:
                  (value) =>
                      Validators.currentPassword(value, _getErrorMessage),
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: l10n.newPassword,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showNewPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _showNewPassword = !_showNewPassword;
                    });
                  },
                ),
              ),
              obscureText: !_showNewPassword,
              validator:
                  (value) => Validators.securePassword(value, _getErrorMessage),
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: l10n.confirmNewPassword,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _showConfirmPassword = !_showConfirmPassword;
                    });
                  },
                ),
              ),
              obscureText: !_showConfirmPassword,
              validator:
                  (value) => Validators.confirmSecurePassword(
                    value,
                    _newPasswordController.text,
                    _getErrorMessage,
                  ),
              enabled: !_isLoading,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSubmit,
          child:
              _isLoading
                  ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : Text(l10n.updatePassword),
        ),
      ],
    );
  }
}
