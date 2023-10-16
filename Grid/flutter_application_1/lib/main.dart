import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Column&Row',
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomeState();
}

class MyHomeState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column&Row Example')),
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 3, 76, 96),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(color: Colors.black, blurRadius: (5.0))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Cell(),
                  Cell(),
                  Cell(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Cell(),
                  Cell(),
                  Cell(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Cell(),
                  Cell(),
                  Cell(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }
}
