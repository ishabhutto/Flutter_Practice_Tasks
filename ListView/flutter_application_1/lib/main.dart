import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = ['item1', 'item2', 'item3', 'item4'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('List View Example'),
      ),
      body:
          // 1- ListView
          ListView(
        children: const [
          ListTile(
            title: Text('Battery Full'),
            leading: Icon(Icons.battery_full),
          ),
          ListTile(
            title: Text('Anchor'),
            leading: Icon(Icons.anchor),
          ),
          ListTile(
            title: Text('Alarm'),
            leading: Icon(Icons.alarm),
          ),
          ListTile(
            title: Text('Ballot'),
            leading: Icon(Icons.ballot),
          ),
        ],
      ),
    );
  }
}
