import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/extensions/extensions.dart';
import 'package:stackbudget/src/core/utils/utils.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model_state.dart';

class DeleteAccountDialog extends ConsumerStatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  ConsumerState<DeleteAccountDialog> createState() =>
      _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends ConsumerState<DeleteAccountDialog> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _showPassword = false;
  bool _confirmDeletion = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  String? _getErrorMessage(String key) {
    final l10n = context.strings;
    switch (key) {
      case 'currentPasswordRequired':
        return l10n.currentPasswordRequired;
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
        .deleteAccount(_passwordController.text);

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
      if (next is ProfileAccountDeletedState) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.accountDeletedSuccess),
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
      title: Text(l10n.deleteAccountConfirmation),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.deleteAccountWarning,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _confirmDeletion,
              onChanged:
                  _isLoading
                      ? null
                      : (value) {
                        setState(() {
                          _confirmDeletion = value ?? false;
                        });
                      },
              title: Text(
                l10n.confirm,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            if (_confirmDeletion) ...[
              const SizedBox(height: 16),
              Text(
                l10n.enterCurrentPasswordToDelete,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: l10n.currentPassword,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !_showPassword,
                  validator:
                      (value) =>
                          Validators.currentPassword(value, _getErrorMessage),
                  enabled: !_isLoading,
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _isLoading || !_confirmDeletion ? null : _handleSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child:
              _isLoading
                  ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                  : Text(l10n.deleteAccountAction),
        ),
      ],
    );
  }
}
