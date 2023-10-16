import 'package:flutter/material.dart';
import 'home.dart';
import 'chat.dart';

class CustomColors {
  static const Color myCustomColor = Color(0xFF142645);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}
