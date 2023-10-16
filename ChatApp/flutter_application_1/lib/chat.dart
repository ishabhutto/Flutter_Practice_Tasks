import 'package:flutter/material.dart';
import 'home.dart';

class CustomColors {
  static const Color myCustomColor = Color(0xFF142645);
}

class MyChat extends StatefulWidget {
  const MyChat({super.key});

  @override
  State<MyChat> createState() => MyChatState();
}

class MyChatState extends State<MyChat> {
  TextEditingController textEditingController = TextEditingController();
  String sentMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.myCustomColor,
        title: const Text(
          'Chat App',
          style: TextStyle(color: Colors.white),
        ),
        leading: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              ),
              child: const Icon(
                Icons.arrow_back,
              ),
            ),
            // First icon
            const SizedBox(width: 8), 
            const Icon(Icons.person), 
          ],
        ),
        actions: [
          // Third icon (video call)
          const Icon(Icons.video_call),
          const SizedBox(width: 30),
          // Fourth icon (audio call)
          const Icon(Icons.call),
          const SizedBox(width: 30),

          // Dots menu (three dots)
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Option 1'),
              ),
              const PopupMenuItem(
                child: Text('Option 2'),
              ),
              const PopupMenuItem(
                child: Text('Option 3'),
              ),
            ],
          ),
          const SizedBox(width: 100),
        ],

        iconTheme: const IconThemeData(
            color: Colors.white), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, 
          children: [
            const SizedBox(height: 16), 
            Text(sentMessage), 
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      labelText: 'Write message ...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    
                    String message = textEditingController.text;
                    setState(() {
                      sentMessage = message; 
                    });
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
