import 'dart:math';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:async';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelGroupKey: "daily_prompts",
        channelKey: "daily_prompts",
        channelName: "memory_prompts",
        channelDescription: "Notification channel for basic test",
        defaultColor: const Color(0xFF9D50DD),
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        onlyAlertOnce: false,
        playSound: true,
        criticalAlerts: true,
      )
    ]);
  }

  static List<String> prompts = [
    "What was your most memorable vacation?",
    "Describe a favorite childhood memory.",
    "What is your proudest accomplishment?",
    "Recall a funny or embarrassing moment from your past.",
    "What is a valuable life lesson you have learned?",
    // Add more prompts here
  ];

  static String promptTitle = '';
  static String promptDescription = '';

  static void _fetchDailyPrompt() {
    // Randomly select a prompt from the list
    final random = Random();
    final randomIndex = random.nextInt(prompts.length);
    final randomPrompt = prompts[randomIndex];

    promptTitle = randomPrompt;
    promptDescription = 'Take a moment to recall and describe your response.';
  }

  static void _scheduleDailyNotification() {
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

    AwesomeNotifications().createNotification(
      content: content,
      schedule: schedule,
    );
  }

  static Future<void> scheduleDailyNotification() async {
    _fetchDailyPrompt();
    _scheduleDailyNotification();
  }
}
