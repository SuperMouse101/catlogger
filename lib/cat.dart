/* Cat Logger Main Cat Page.*/
import 'package:catlogger/cat_settings.dart';
import 'package:catlogger/metric.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'data_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // for dialog box
  String? name;
  int? age;
  String? breed;
  Timestamp? date;
  int? weight;
  String? desc;

  File? _image;

  @override
  void initState() {
    super.initState();

    curr = widget.curr;
  }

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String currDate() {
    final dynamic dateValue = curr['date'];

    if (dateValue is Timestamp) {
      // Convert Firebase Timestamp to Dart DateTime
      DateTime dateTime = dateValue.toDate();
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } else if (dateValue is DateTime) {
      // If it's already a DateTime, format it directly
      return DateFormat('yyyy-MM-dd').format(dateValue);
    } else {
      // Handle cases where 'date' might be null or a different unexpected type
      return ''; // Or throw an error, log a warning, etc.
    }
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
                        foregroundImage: _image != null ? FileImage(_image!) : null,
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Update ${curr['name']}'),
                              content: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      initialValue: curr['name'],
                                      decoration: const InputDecoration(hintText: 'Cats name'),
                                      validator: (String? name) {
                                        if (name == null || name.isEmpty) {
                                          return 'Please enter the cats name';
                                        }
                                        this.name = name;
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      initialValue: '${curr['age']}',
                                      decoration: const InputDecoration(hintText: 'Cats age'),
                                      validator: (age) {
                                        if (age!.isEmpty) {
                                          return 'Please enter the cats age';
                                        }
                                        else if(int.parse(age) < 0 && int.parse(age) > 25) {
                                          return 'Age must be within 0-25';
                                        }
                                        this.age = int.parse(age);
                                        return null;
                                      },
                                      keyboardType: TextInputType.numberWithOptions(),
                                    ),
                                    TextFormField(
                                      initialValue: curr['breed'],
                                      decoration: const InputDecoration(hintText: 'Cats breed'),
                                      validator: (breed) {
                                        if (breed!.isEmpty) {
                                          return null;
                                        }
                                        this.breed = breed;
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      initialValue: currDate(),
                                      decoration: const InputDecoration(hintText: 'Cats Birth Date'),
                                      validator: (date) {
                                        if (date!.isEmpty) {
                                          return null;
                                        }
                                        try {
                                          // Try to parse the input string into a DateTime
                                          DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
                                          // If parsing is successful, format it back to the desired string format
                                          this.date = Timestamp.fromDate(parsedDate);
                                          return null; // Validation successful
                                        } catch (e) {
                                          return 'Please enter a valid date in YYYY-MM-DD format'; // Validation failed
                                        }
                                      },
                                      keyboardType: TextInputType.datetime,
                                    ),
                                    TextFormField(
                                      initialValue:  curr['weight'] == null ? '' : '${curr['weight']}',
                                      decoration: const InputDecoration(hintText: 'Cats weight'),
                                      validator: (weight) {
                                        if (weight!.isEmpty) {
                                          return null;
                                        }
                                        else if(int.parse(weight) < 0) {
                                          return 'Weight can not be below 0';
                                        }
                                        this.weight = int.parse(weight);
                                        return null;
                                      },
                                      keyboardType: TextInputType.numberWithOptions(),
                                    ),
                                    TextFormField(
                                      initialValue: curr['desc'],
                                      decoration: const InputDecoration(hintText: 'Cats Description'),
                                      validator: (desc) {
                                        if (desc!.isEmpty) {
                                          return null;
                                        }
                                        this.desc = desc;
                                        return null;
                                      },
                                      maxLines: 5,
                                      keyboardType: TextInputType.multiline
                                    ),
                                  ],
                                )
                              ),
                              actions: <Widget>[ 
                                TextButton( // Update action. Updates your cat with the info above
                                  child: const Text('Update'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        curr['name'] = name;
                                        curr['age'] = age;
                                        curr['breed'] = breed;
                                        curr['date'] = date;
                                        curr['weight'] = weight;
                                        curr['desc'] = desc;
                                        updateData(curr);
                                      });
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                                TextButton( // Cancel action.
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
                          style: TextStyle(color: Colors.white70),
                        ),
                        if(curr['breed'] != null) 
                          Text(
                            curr['breed'],
                            style: TextStyle(color: Colors.white70),
                          )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          'Birth Date:',
                          style: TextStyle(color: Colors.white70),
                        ),
                        if(curr['date'] != null) 
                          Text(
                            currDate(),
                            style: TextStyle(color: Colors.white70),
                          )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          'Weight:',
                          style: TextStyle(color: Colors.white70),
                        ),
                        if(curr['weight'] != null) 
                          Text(
                            "${curr['weight']}",
                            style: TextStyle(color: Colors.white70),
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