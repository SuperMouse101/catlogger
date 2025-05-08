/* Cat Logger Main Cat Page.*/
import 'package:catlogger/cat_settings.dart';
import 'package:catlogger/metric.dart';
import 'package:flutter/material.dart';
import 'data_functions.dart';

import 'home.dart';
import 'user_settings.dart';

class MyCatPage extends StatefulWidget {
  const MyCatPage({super.key, required this.curr});

  final Map<String, dynamic> curr;

  @override
  State<MyCatPage> createState() => _MyCatPageState();
}

class _MyCatPageState extends State<MyCatPage> {
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
        MaterialPageRoute(builder: (context) =>  MyCatPage(curr: curr)),
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
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Handle edit action
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: [
                        const Text(
                          'Breed:',
                          style: TextStyle(color: Colors.white),
                        ),
                        if(curr['breed'] != null) 
                          Text(
                            curr['breed'],
                            style: TextStyle(color: Colors.white),
                          )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          'Birth Date:',
                          style: TextStyle(color: Colors.white),
                        ),
                        if(curr['date'] != null) 
                          Text(
                            curr['date'],
                            style: TextStyle(color: Colors.white),
                          )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          'Weight:',
                          style: TextStyle(color: Colors.white),
                        ),
                        if(curr['weight'] != null) 
                          Text(
                            "${curr['weight']}",
                            style: TextStyle(color: Colors.white),
                          )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Basic Description: ',
                  style: TextStyle(color: Colors.white),
                ),
                if(curr['desc'] != null) 
                  Text(
                    curr['desc'],
                    style: TextStyle(color: Colors.white),
                  ),
                const SizedBox(height: 8.0),

              ],
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
        currentIndex: 0,
        selectedItemColor: Color.fromARGB(255, 79, 16, 197),
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        onTap: _onItemTapped,
      ),
    );
  }
}