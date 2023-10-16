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
            const SizedBox(width: 8), // Add spacing between icons
            const Icon(Icons.person), // Second icon
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
            color: Colors.white), // Set the color of the icon
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Align at the bottom
          children: [
            const SizedBox(height: 16), // Add spacing
            Text(sentMessage), // Display sent message
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
                    // Action when send button is pressed
                    String message = textEditingController.text;
                    setState(() {
                      sentMessage = message; // Update the sent message
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
