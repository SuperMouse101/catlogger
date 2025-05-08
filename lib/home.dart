/* Cat Logger Main Page.*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data_functions.dart';

import 'user_settings.dart';
import 'cat.dart';
import 'metric.dart';
import 'cat_settings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Main class
class _MyHomePageState extends State<MyHomePage> {
  /* Useful variables used through the main page
   * _textFieldController - helps in adding new cats to the page
   * entries - list of cat entries
   * value - used to add new cats to the list
   */
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final TextEditingController _textFieldController = TextEditingController();
  List<Map<String, dynamic>> entries = [];
  String value = "";
  int ageValue = 0;
  int length = 0;

  @override
  void initState() {
    super.initState();
    _accessAllDocuments();
  }

  Future<void> _accessAllDocuments() async {
    QuerySnapshot<Object?> snapshot = await queryData();
    List<Map<String, dynamic>> incomingData = [];

    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          incomingData.add({
            'name': data['name'],
            'age': data['age'],
            'uid': data['uid'],
            'breed': data['breed'],
            'date': data['date'],
            'weight': data['weight'],
            'desc': data['desc'],
            'id': doc.id
          });
        }
      }
      setState(() {
        entries = incomingData;
        length = snapshot.docs.length;
      });
    }
  }

  // main build
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
      // Main body, containing a list of your cats and a create button
      body: Center(
        child: ListView.separated(
          padding: EdgeInsets.all(8),
          itemCount: length+1, // total amount of cats plus a create new cat button
          itemBuilder: (BuildContext context, int index) {
            // if the index is less than the length, it will list every cat you have
            if(index < entries.length) {
              final curr = entries[index];
              return Container(
                height: 68,
                color: Color.fromARGB(255, 34, 34, 34),
                // puts the content of the card in a singular row
                child: Row(
                  children: [
                    const SizedBox(width: 6),
                    // Image container WIP
                    SizedBox(
                      width: 80.0,
                      height: 80.0,
                      child: CircleAvatar(
                        // ... image or placeholder
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Name and Age Column
                    Column(
                      children: [
                        Spacer(),
                        Text( // Name
                          curr['name'],
                          style: TextStyle(color: Color.fromARGB(255,255,255,255)),
                        ),
                        Text( // Age WIP
                          "Age: ${curr['age']}",
                          style: TextStyle(color: Color.fromARGB(255,255,255,255)),
                        ),
                        Spacer()
                      ],
                    ),
                    Spacer(),
                    // set of Icon Buttons that lead to that cats various pages
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => MyCatPage(curr: curr)),
                        );
                      }, 
                      icon: Icon(Icons.home, color: Color.fromARGB(255,255,255,255),)
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => MyMetricPage(curr: curr)),
                        );
                      }, 
                      icon: Icon(Icons.bar_chart, color: Color.fromARGB(255,255,255,255),)
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => MySettingsPage(curr: curr)),
                        );
                      }, 
                      icon: Icon(Icons.settings, color: Color.fromARGB(255,255,255,255),)
                    ),
                    const SizedBox(width: 6)
                  ],
                ),
              );
            }
            // else, it will create the create new cat button
            else {
              return ElevatedButton.icon(
                // When pressed, it will show a pop up asking you to name your new cat
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('New Cat'),
                        content: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(hintText: 'Enter your cats name'),
                                validator: (String? name) {
                                  if (name == null || name.isEmpty) {
                                    return 'Please enter the cats name';
                                  }
                                  value = name;
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: const InputDecoration(hintText: 'Enter your cats age'),
                                validator: (age) {
                                  if (age!.isEmpty) {
                                    return 'Please enter the cats age';
                                  }
                                  else if(int.parse(age) < 0 && int.parse(age) > 25) {
                                    return 'Age must be within 0-25';
                                  }
                                  ageValue = int.parse(age);
                                  return null;
                                },
                                keyboardType: TextInputType.numberWithOptions(),
                              ),
                            ],
                          )
                        ),
                        actions: <Widget>[ 
                          TextButton( // Add action. Adds your cat with the name and age set above
                            child: const Text('Add'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  insertData(value, ageValue);
                                  value = "";
                                  _accessAllDocuments();
                                });
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                          TextButton( // Cancel action. Cancles the creation of your new cat
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              value = "";
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'Create',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(1, 48)
                ),
              );
            }
          },
          separatorBuilder: (context, index) => const Divider(thickness: 0),
        ),
      ),
    );
  }
}
