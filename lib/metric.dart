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

  List<DropdownMenuEntry<dynamic>> entries = [
    const DropdownMenuEntry(value: 'Severly Underweight', label: 'Severly Underweight'), 
    const DropdownMenuEntry(value: 'Very Thin', label: 'Very Thin'),
    const DropdownMenuEntry(value: 'Thin', label: 'Thin'),
    const DropdownMenuEntry(value: 'Slightly Underweight', label: 'Slightly Underweight'),
    const DropdownMenuEntry(value: 'Ideal Weigth', label: 'Ideal Weigth'),
    const DropdownMenuEntry(value: 'Slightly Overweight', label: 'Slightly Overweight'),
    const DropdownMenuEntry(value: 'Markedly Overweight', label: 'Markedly Overweight'),
    const DropdownMenuEntry(value: 'Obese', label: 'Obese'),
    const DropdownMenuEntry(value: 'Clinically Obese', label: 'Clinically Obese'),
  ];

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 80.0,
                      height: 80.0,
                      child: CircleAvatar(
                        // WIP
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            curr['name'], 
                            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white)
                          ),
                          Text(
                            "Age: ${curr['age']}", 
                            style: TextStyle(color: Colors.white70)
                          ),
                          Text(
                            "Weight: ${curr['weight']}",
                            style: TextStyle(color: Colors.white70)
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
                DropdownMenu(
                  dropdownMenuEntries: entries,
                  initialSelection: 4,
                  textStyle: TextStyle(color: Colors.white),
                  
                )
              ]
            ), 
          ),
        ),
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