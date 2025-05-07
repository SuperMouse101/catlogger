/* Cat Logger User Settings Page.*/
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';

class MyUserPage extends StatefulWidget {
  const MyUserPage({super.key});

  @override
  State<MyUserPage> createState() => _MyUserPageState();
}

class _MyUserPageState extends State<MyUserPage> {

  Future<void> _signOutFirebase() async {
    await FirebaseAuth.instance.signOut();
    if(mounted){
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar has a back button and profile settings button
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 34, 34, 34),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          }, 
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255,255,255,255),)
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const MyUserPage()),
              );
            }, 
            icon: Icon(Icons.account_circle, color: Color.fromARGB(255,255,255,255),)
          )
        ],
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              textColor: Color.fromARGB(255, 0, 0, 0),
              title: const Text("WIP"),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: _signOutFirebase,
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}