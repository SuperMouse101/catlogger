import 'package:catlogger/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key, required this.title});
  
  final String title;

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _createAccount() async {
    if(_formKey.currentState!.validate()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text,
      );
      if(mounted){
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 34, 34, 34),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const AuthPage()),
            );
          }, 
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255,255,255,255),)
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email *',
                  icon: Icon(Icons.person),
                  iconColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                validator:(value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter your email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Password *',
                  icon: Icon(Icons.password),
                  iconColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                validator:(value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter a password';
                  }
                  if(value.length < 6) {
                    return 'Password mush have at least 6 characters';
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Comfirm Password *',
                  icon: Icon(Icons.password),
                  iconColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                validator:(value) {
                  if(value != _passwordController.text){
                    return 'Passwords do not match. Please try again.';
                  }
                  if(value == null || value.isEmpty){
                    return 'Please comfirm your password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _createAccount,
                child: const Text('Create an Account'),
              ),
              Spacer()
            ],
          )
        ),
      ),
    );
  }
}
