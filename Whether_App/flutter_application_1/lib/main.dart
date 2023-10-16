import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => MyHomeState();
}

class MyHomeState extends State<MyHomePage> {
  Future<Map<String, dynamic>> fetchData(String location) async {
    final apiKey = '9d6f33df980f44268e9153248231210';
    final response = await http.get(Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load the data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Weather App'),
        ),
        body: Center(
            child: FutureBuilder<Map<String, dynamic>>(
          future: fetchData('London'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final data = snapshot.data!;
              final temperatureC = data['current']['temp_c'];
              final condition = data['current']['condition']['text'];
              final location = data['location']['name'];

              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text('Location: $location'),
                      Text('Temperature: $temperatureC°C'),
                      Text('Condition: $condition'),
                    ],
                  );
                },
              );
            }
          },
        )));
  }
}
