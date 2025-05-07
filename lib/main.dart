import 'package:catlogger/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';
import 'auth.dart';
import 'create.dart';
import 'login.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

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
    GoRoute(
      path: '/create',
      builder: (context, state) => const CreateUser(title: 'Create Account'),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(title: 'Login'),
    ),
  ],
);

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