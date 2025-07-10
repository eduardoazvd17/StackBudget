import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  static const routeName = 'auth';
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth')),
      body: Container(),
    );
  }
}
