import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/extensions/extensions.dart';
import 'package:stackbudget/src/core/utils/utils.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model_state.dart';

class ChangeNameDialog extends ConsumerStatefulWidget {
  final String currentName;

  const ChangeNameDialog({super.key, required this.currentName});

  @override
  ConsumerState<ChangeNameDialog> createState() => _ChangeNameDialogState();
}

class _ChangeNameDialogState extends ConsumerState<ChangeNameDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String? _getErrorMessage(String key) {
    final l10n = context.strings;
    switch (key) {
      case 'nameRequired':
        return l10n.nameRequired;
      case 'nameMinLength':
        return l10n.nameMinLength;
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
        .updateName(_nameController.text.trim());

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
      if (next is ProfileNameUpdatedState) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.nameUpdatedSuccess),
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
      title: Text(l10n.changeName),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.newName,
                hintText: l10n.currentName,
                border: const OutlineInputBorder(),
              ),
              validator:
                  (value) => Validators.profileName(value, _getErrorMessage),
              enabled: !_isLoading,
              textCapitalization: TextCapitalization.words,
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
                  : Text(l10n.updateName),
        ),
      ],
    );
  }
}
