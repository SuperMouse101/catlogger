import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context.go('/create'),
            child: const Text('Create Account'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/login'),
            child: const Text('Login'),
          ),
        ],
      ),
    ),
  );

  }
}
