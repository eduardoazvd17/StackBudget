import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';

class AuthForm extends ConsumerStatefulWidget {
  const AuthForm({super.key});

  @override
  ConsumerState<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSignUp = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _isSignUp = !_isSignUp;
      _formKey.currentState?.reset();
    });
    ref.read(authViewModelProvider.notifier).clearError();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final name = _nameController.text.trim();

    if (_isSignUp) {
      await ref
          .read(authViewModelProvider.notifier)
          .signUpWithEmailAndPassword(
            email: email,
            password: password,
            name: name,
          );
    } else {
      await ref
          .read(authViewModelProvider.notifier)
          .signInWithEmailAndPassword(email: email, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    ref.listen<AuthViewModelState>(authViewModelProvider, (previous, next) {
      if (next is AuthErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  next.exception.getTitle(context),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(next.exception.getMessage(context)),
              ],
            ),
            backgroundColor: context.colorScheme.error,
            duration: const Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _isSignUp ? 'Criar Conta' : 'Entrar',
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacing.lg),

          if (_isSignUp) ...[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.person_outline),
              ),
              textInputAction: TextInputAction.next,
              validator: Validators.required,
              enabled: authState is! AuthLoadingState,
            ),
            const SizedBox(height: Spacing.md),
          ],

          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: Validators.email,
            enabled: authState is! AuthLoadingState,
          ),
          const SizedBox(height: Spacing.md),

          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Senha',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            obscureText: !_isPasswordVisible,
            textInputAction:
                _isSignUp ? TextInputAction.next : TextInputAction.done,
            validator: _isSignUp ? Validators.password : Validators.required,
            enabled: authState is! AuthLoadingState,
            onFieldSubmitted: _isSignUp ? null : (_) => _submit(),
          ),

          if (_isSignUp) ...[
            const SizedBox(height: Spacing.md),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isConfirmPasswordVisible,
              textInputAction: TextInputAction.done,
              validator:
                  (value) => Validators.confirmPassword(
                    value,
                    _passwordController.text,
                  ),
              enabled: authState is! AuthLoadingState,
              onFieldSubmitted: (_) => _submit(),
            ),
          ],

          const SizedBox(height: Spacing.xl),

          ElevatedButton(
            onPressed: authState is AuthLoadingState ? null : _submit,
            child:
                authState is AuthLoadingState
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : Text(_isSignUp ? 'Criar Conta' : 'Entrar'),
          ),

          const SizedBox(height: Spacing.md),

          TextButton(
            onPressed: authState is AuthLoadingState ? null : _toggleMode,
            child: Text(
              _isSignUp
                  ? 'Já tem uma conta? Entre aqui'
                  : 'Não tem uma conta? Cadastre-se',
            ),
          ),
        ],
      ),
    );
  }
}
