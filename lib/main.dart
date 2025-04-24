import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';
import 'auth.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        if(FirebaseAuth.instance.currentUser == null) {
          return const AuthPage();
        } else {
          return const MyHomePage();
        }
      }
    ),
  ],
);

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cat Logger',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(100, 90, 46, 171)
      ),
      routerConfig: _router,
    );
  }
}