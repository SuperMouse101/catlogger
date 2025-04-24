import 'package:flutter/material.dart';
import 'data_functions.dart';

import 'home.dart';

void main() async{
  initializeDatabase();
  runApp(const MyApp());
}

