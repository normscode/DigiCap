import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:math';

class NotificationScreen extends StatefulWidget {
  @override
  _MemoryPromptsPageState createState() => _MemoryPromptsPageState();
}

class _MemoryPromptsPageState extends State<NotificationScreen> {
  List<String> prompts = [
    "What was your most memorable vacation?",
    "Describe a favorite childhood memory.",
    "What is your proudest accomplishment?",
    "Recall a funny or embarrassing moment from your past.",
    "What is a valuable life lesson you have learned?",
    // Add more prompts here
  ];

  String promptTitle = '';
  String promptDescription = '';

  @override
  void initState() {
    super.initState();
    _fetchDailyPrompt();
    // _scheduleDailyNotification();
  }

  void _fetchDailyPrompt() {
    // Randomly select a prompt from the list
    final random = Random();
    final randomIndex = random.nextInt(prompts.length);
    final randomPrompt = prompts[randomIndex];

    setState(() {
      promptTitle = randomPrompt;
      promptDescription = 'Take a moment to recall and describe your response.';
    });
  }

  void _scheduleDailyNotification() {
    final content = NotificationContent(
      id: 1,
      channelKey: 'daily_prompts',
      title: promptTitle,
      body: promptDescription,
    );

    final now = DateTime.now();
    final schedule = NotificationCalendar(
      weekday: now.weekday,
      hour: now.hour,
      minute: now.minute,
      second: now.second + 5, // Schedule after 5 seconds
      millisecond: now.millisecond,
      allowWhileIdle: true,
    );

    // final schedule = NotificationCalendar(
    //   weekday: DateTime.now().weekday,
    //   hour: 0, // Set the desired time for the notification
    //   minute: 0,
    //   second: 5,
    //   millisecond: 0,
    //   allowWhileIdle: true,
    // );

    AwesomeNotifications().createNotification(
      content: content,
      schedule: schedule,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding:
              EdgeInsets.all(20.0), // Optional: Add padding to the container
          decoration: BoxDecoration(
            // Optional: Add decoration properties to the container
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                promptTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                promptDescription,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
