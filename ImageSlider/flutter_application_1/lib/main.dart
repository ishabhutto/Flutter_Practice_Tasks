import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => MyHomeState();
}

class MyHomeState extends State<MyHomePage> {
  Offset offset = const Offset(0.0, 0.0);
  double scale = 1.0;
  String imagePath = 'assets/img1.png';

  void handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      scale = details.scale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Image Slider'),
      ),
      body: GestureDetector(
        onScaleUpdate: handleScaleUpdate,
        child: Transform.scale(
          scale: scale,
          child: InkWell(
            onTap: () {
              setState(() {
                imagePath = 'assets/img2.png';
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      imagePath = 'assets/img2.jpg';
                    });
                  },
                  child: Image.asset(
                    imagePath,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Transform.scale(
                  // offset: offset,
                  scale: scale,
                  child: Center(
                    child: Container(
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
