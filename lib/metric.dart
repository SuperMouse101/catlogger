/* Cat Logger Metric Page.*/
import 'dart:collection';

import 'package:catlogger/cat.dart';
import 'package:catlogger/cat_settings.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'home.dart';
import 'user_settings.dart';

typedef WeightEntry = DropdownMenuEntry<Weightlabel>;

enum Weightlabel {
  severlyUnderweight("Severly Underweight"),
  veryThin("Very Thin"),
  thin("Thin"),
  slightlyUnderweight("Slightly Underweight"),
  ideal("Ideal Weight"),
  slightlyOverweight("Slightly Overweight"),
  remarkedlyOverweight("Remarkedly Overweight"),
  obese("Obese"),
  clinicallyObese("Clinically Obese");
  
  const Weightlabel(this.label);
  final String label;

  static final List<WeightEntry> entries = UnmodifiableListView<WeightEntry>(
    values.map<WeightEntry>((Weightlabel value) => DropdownMenuEntry<Weightlabel>(
      value: value,
      label: value.label,
    )),
  );
}
class MyMetricPage extends StatefulWidget {
  const MyMetricPage({super.key, required this.curr});

  final Map<String, dynamic> curr;

  @override
  State<MyMetricPage> createState() => _MyMetricPageState();
}

class _MyMetricPageState extends State<MyMetricPage> {
  Map<String, dynamic> curr = {};
  double factor = 1;
  double? mer;

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

double getWeightIndex(Weightlabel label) {
  if(curr["age"] == 0) {
    return 2.4;
  }
  else if(curr["age"] > 14) {
    return 1;
  }
  switch (label) {
    case Weightlabel.severlyUnderweight:
      return 1.7;
    case Weightlabel.veryThin:
      return 1.6;
    case Weightlabel.thin:
      return 1.5;
    case Weightlabel.slightlyUnderweight:
      return 1.4;
    case Weightlabel.ideal:
      return 1;
    case Weightlabel.slightlyOverweight:
      return 0.9;
    case Weightlabel.remarkedlyOverweight:
      return 0.8;
    case Weightlabel.obese:
      return 0.8;
    case Weightlabel.clinicallyObese:
      return 0.8;
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
                DropdownMenu<Weightlabel>(
                  dropdownMenuEntries: Weightlabel.entries,
                  initialSelection: Weightlabel.ideal,
                  textStyle: TextStyle(color: Colors.white),
                  onSelected: (Weightlabel ?value) => {
                    setState(() {
                      if(value != null) {
                        factor = getWeightIndex(value);
                      }
                    })
                  },
                ),
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          mer = (70 * pow(curr['weight'], 0.75).toDouble()) * factor;
                        });
                      }, 
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.grey)),
                      child: const Text("Calculate")
                    ),
                    Spacer()
                  ]
                ),
                if(mer != null)
                  Text(
                    '${mer?.toStringAsFixed(3)} calories per day',
                    style: TextStyle(color: Colors.white)
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