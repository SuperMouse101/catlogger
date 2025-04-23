/* Cat Logger Metric Page.*/
import 'package:flutter/material.dart';

import 'main.dart';
import 'user_settings.dart';

class MyMetricPage extends StatefulWidget {
  const MyMetricPage({super.key});

  @override
  State<MyMetricPage> createState() => _MyMetricPageState();
}

class _MyMetricPageState extends State<MyMetricPage> {
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