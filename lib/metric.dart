/* Cat Logger Metric Page.*/
import 'package:catlogger/cat.dart';
import 'package:catlogger/cat_settings.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'user_settings.dart';

class MyMetricPage extends StatefulWidget {
  const MyMetricPage({super.key, required this.curr});

  final Map<String, dynamic> curr;

  @override
  State<MyMetricPage> createState() => _MyMetricPageState();
}

class _MyMetricPageState extends State<MyMetricPage> {
  Map<String, dynamic> curr = {};

  @override
  void initState() {
    super.initState();

    curr = widget.curr;
  }

  void _onItemTapped(int index) {
    if(index == 0) {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => MyCatPage(curr: curr)),
      );
    }
    else if(index == 1) {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => MyMetricPage(curr: curr)),
      );
    }
    else if(index == 2) {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => MySettingsPage(curr: curr)),
      );
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
      body: Center(
        child: Text(
          "WIP Metrics",
          style: TextStyle(color: Color.fromARGB(255,255,255,255)),
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Metrics'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 1,
        selectedItemColor: Color.fromARGB(255, 79, 16, 197),
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        onTap: _onItemTapped,
      ),
    );
  }
}