/* Cat Logger Main Cat Page.*/
import 'package:flutter/material.dart';

import 'main.dart';
import 'user_settings.dart';

class MyCatPage extends StatefulWidget {
  const MyCatPage({super.key});

  @override
  State<MyCatPage> createState() => _MyCatPageState();
}

class _MyCatPageState extends State<MyCatPage> {
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
      body: Center(
        child: Text(
          "WIP",
          style: TextStyle(color: Color.fromARGB(255,255,255,255)),
        )
      ),
    );
  }
}