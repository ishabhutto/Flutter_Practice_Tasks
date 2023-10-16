import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/provider.dart';
import 'package:shopping_cart/home.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => CartProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Shopping Cart App', home: MyHomePage());
  }
}
