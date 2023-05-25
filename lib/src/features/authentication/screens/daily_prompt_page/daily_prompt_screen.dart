import 'package:flutter/material.dart';
import 'dart:math';

List<String> memoryPrompts = [
  "What was your most memorable vacation?",
  "Describe a favorite childhood memory.",
  // Add more prompts here
];

class DailyPromptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String prompt = getRandomPrompt();

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Memory Prompt'),
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              prompt,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }

  String getRandomPrompt() {
    Random random = Random();
    int randomIndex = random.nextInt(memoryPrompts.length);
    return memoryPrompts[randomIndex];
  }
}
