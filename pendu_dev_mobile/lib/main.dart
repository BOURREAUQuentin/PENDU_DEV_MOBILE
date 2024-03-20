import 'package:flutter/material.dart';
import 'UI/home.dart';
import 'UI/rules.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pendu Dev Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Rules(),
    );
  }
}
