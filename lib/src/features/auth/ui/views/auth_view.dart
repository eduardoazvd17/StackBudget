import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';

class AuthView extends StatelessWidget {
  static const routeName = 'auth';
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth')),
      body: Center(
        child: SingleChildScrollView(
          padding: Spacing.page.padding,
          child: Container(),
        ),
      ),
    );
  }
}
