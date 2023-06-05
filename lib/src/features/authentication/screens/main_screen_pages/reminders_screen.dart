import 'package:flutter/material.dart';
import 'dart:math';

class ReminderScreen extends StatefulWidget {
  @override
  _MemoryPromptsPageState createState() => _MemoryPromptsPageState();
}

class _MemoryPromptsPageState extends State<ReminderScreen> {
  List<String> prompts = [
    "What was your most memorable vacation?",
    "Describe a favorite childhood memory.",
    "What is your proudest accomplishment?",
    "Recall a funny or embarrassing moment from your past.",
    "What is a valuable life lesson you have learned?",
    "Share a memorable family tradition from your childhood.",
    "Describe a special friendship that had a significant impact on your life.",
    "What was your favorite subject in school and why?",
    "Recall a challenging obstacle you overcame and how it shaped you.",
    "Share a memorable birthday celebration you had.",
    "Describe a significant milestone in your life and why it was important to you.",
    "What was your favorite game or activity as a child?",
    "Recall a moment when you felt truly inspired or motivated.",
    "Share a memorable experience you had while traveling.",
    "Describe a time when you had to make a difficult decision and how you handled it.",
    "What was your favorite book or movie growing up and why?",
    "Recall a memorable school project or presentation you worked on.",
    "Share a funny or heartwarming story involving your pet or an animal you encountered.",
    "Describe a special talent or skill you have and how you discovered it.",
    "What was your favorite family holiday tradition?",
    "Recall a memorable concert or live performance you attended.",
    "Share a moment when you felt a strong sense of accomplishment.",
    "Describe a significant cultural or historical event that impacted your life.",
    "What was your favorite childhood toy or game and why?",
    "Recall a memorable experience you had while participating in a sport or physical activity.",
    "Share a funny or memorable family gathering or reunion.",
    "Describe a time when you had to overcome a fear or face a phobia.",
    "What was your favorite hobby or pastime as a child?",
    "Recall a special moment or achievement from your academic or professional life.",
    "Share a memorable road trip or adventure you embarked on.",
    "Describe a cherished possession or keepsake from your past.",
    "What was your favorite TV show or cartoon growing up and why?",
    "Recall a time when you received unexpected kindness from a stranger.",
    "Share a funny or memorable experience from a school field trip.",
    "Describe a special family tradition that brings you joy.",
    "What was your favorite outdoor activity or game as a child?",
    "Recall a moment when you felt a strong sense of gratitude.",
    "Share a memorable experience you had while volunteering or helping others.",
    "Describe a time when you had to navigate a difficult or challenging relationship.",
    "What was your favorite food or meal as a child and why?",
    "Recall a funny or heartwarming story involving your siblings or cousins.",
    "Share a moment when you felt a deep connection with nature or the environment.",
    "Describe a time when you had to persevere through adversity.",
    "What was your favorite school subject and why?",
    "Recall a memorable performance or show you participated in.",
    "Share a funny or memorable experience from a summer camp or retreat.",
    "Describe a time when you had to overcome stage fright or public speaking anxiety.",
    "What was your favorite board game or card game growing up and why?",
    "Recall a moment when you received an unexpected gift or surprise.",
    "Share a memorable experience you had while pursuing a creative hobby or artistic endeavor.",
    "Describe a time when you had to navigate a difficult or challenging work situation.",
    "What was your favorite childhood snack or treat and why?",
    "Recall a funny or memorable story involving your grandparents or older relatives.",
    "Share a moment when you felt a strong sense of community or belonging.",
    "Describe a time when you had to step out of your comfort zone and try something new.",
    "What was your favorite school field trip or educational outing and why?",
    "Recall a memorable experience you had while attending a wedding or celebration.",
    "Share a funny or heartwarming story involving your best friend or closest companion.",
    "Describe a time when you had to overcome a personal fear or phobia.",
    "What was your favorite subject or activity in extracurricular clubs or organizations?",
    "Recall a moment when you received recognition or an award for your achievements.",
    "Share a memorable experience you had while exploring a new city or place.",
    "Describe a special piece of jewelry or accessory that holds sentimental value.",
    "What was your favorite childhood game to play with your friends and why?",
    "Recall a time when you helped someone in need or performed a random act of kindness.",
    "Share a funny or memorable experience from a family holiday or vacation.",
    "Describe a time when you had to confront a difficult or uncomfortable truth.",
    "What was your favorite musical instrument or artistic medium growing up and why?",
    "Recall a moment when you witnessed an act of kindness or generosity in your community.",
    "Share a memorable experience you had while participating in a cultural or religious celebration.",
    "Describe a time when you had to make a sacrifice for the greater good.",
    "What was your favorite subject in college or higher education and why?",
    "Recall a memorable performance or exhibition you attended.",
    "Share a funny or heartwarming story involving a family tradition or ritual.",
    "Describe a time when you felt a strong sense of purpose or direction in your life.",
    "What was your favorite science experiment or project in school and why?",
    "Recall a moment when you received unexpected support or encouragement from someone.",
    "Share a memorable experience you had while engaging in a recreational or outdoor activity.",
    "Describe a special place or location that holds significance in your life.",
    "What was your favorite play or theatrical production growing up and why?",
    "Recall a time when you encountered a difficult or challenging situation while traveling.",
    "Share a funny or memorable experience from a family gathering or reunion.",
    "Describe a time when you had to navigate a cultural or language barrier.",
    "What was your favorite childhood game to play outdoors and why?",
    "Recall a moment when you received unexpected advice or wisdom from someone older.",
    "Share a memorable experience you had while participating in a charity or philanthropic event.",
    "Describe a time when you had to confront a personal fear or insecurity.",
    "What was your favorite subject or activity in after-school programs or clubs?",
    "Recall a memorable experience you had while attending a music concert or live performance.",
    "Share a funny or heartwarming story involving your parents or guardians.",
    "Describe a time when you had to overcome a significant challenge or setback.",
    "What was your favorite toy or game to play indoors and why?",
    "Recall a moment when you witnessed an act of bravery or courage.",
    "Share a memorable experience you had while exploring nature or the great outdoors.",
    "Describe a time when you had to make a difficult ethical or moral decision.",
    "What was your favorite art project or creative endeavor in school and why?",
    "Recall a funny or memorable story involving your extended family or relatives.",
    "Share a moment when you felt a strong sense of empowerment or independence.",
    "Describe a time when you had to navigate a conflict or disagreement with a friend.",
    "What was your favorite childhood TV show or cartoon character and why?",
    "Recall a memorable experience you had while participating in a sports competition or athletic event.",
    "Share a funny or heartwarming story involving your siblings or childhood friends.",
    "Describe a time when you had to overcome a significant academic or intellectual challenge.",
    "What was your favorite subject or activity in summer camps or recreational programs?",
    "Recall a moment when you received unexpected support or encouragement from a teacher or mentor.",
    "Share a memorable experience you had while attending a festival or cultural event.",
    "Describe a time when you had to navigate a difficult or life-changing decision.",
    "What was your favorite childhood TV commercial or advertisement and why?",
    "Recall a funny or memorable story involving your neighbors or community members.",
    "Share a moment when you felt a strong sense of compassion or empathy towards others.",
    "Describe a time when you had to confront a personal belief or challenge your own perspective.",
    "What was your favorite outdoor adventure or exploration as a child and why?",
    "Recall a memorable experience you had while participating in a volunteer or service project.",
    "Share a funny or heartwarming story involving your pets or animals you encountered.",
    "Describe a time when you had to adapt to a new environment or navigate a cultural transition.",
    "What was your favorite childhood memory related to food or cooking?",
    "Recall a moment when you received unexpected recognition or praise for your talents.",
    "Share a memorable experience you had while participating in a science fair or exhibition.",
    "Describe a time when you had to navigate a challenging or conflicting relationship with a peer.",
    "What was your favorite video game or computer game growing up and why?",
    "Recall a funny or memorable story involving a misunderstanding or miscommunication.",
    "Share a moment when you felt a strong sense of belonging or acceptance in a group.",
    "Describe a time when you had to overcome a personal limitation or physical challenge.",
    "What was your favorite childhood tradition or ritual and why?",
    "Recall a memorable experience you had while participating in a community or social event.",
    "Share a funny or heartwarming story involving your parents or grandparents.",
    "Describe a time when you had to navigate a difficult or stressful work or academic project.",
    "What was your favorite hobby or activity during weekends or free time as a child?",
    "Recall a moment when you received unexpected kindness or generosity from a stranger.",
    "Share a memorable experience you had while exploring a museum or art gallery.",
    "Describe a time when you had to confront a personal fear of failure or rejection.",
    "What was your favorite childhood memory related to technology or gadgets?",
    "Recall a funny or memorable story involving a classmate or schoolmate.",
    "Share a moment when you felt a strong sense of purpose or calling in your life.",
    "Describe a time when you had to navigate a difficult or challenging family situation.",
    "What was your favorite childhood game to play indoors with siblings or friends and why?",
    "Recall a memorable experience you had while attending a cultural or religious ceremony.",
    "Share a funny or heartwarming story involving a teacher or educator.",
    "Describe a time when you had to overcome a personal setback or disappointment.",
    "What was your favorite school event or celebration growing up and why?",
    "Recall a moment when you witnessed an act of generosity or selflessness in your community.",
    "Share a memorable experience you had while participating in a leadership or team-building program.",
    "Describe a time when you had to navigate a difficult or challenging financial situation.",
    "What was your favorite childhood memory related to music or singing and why?",
    "Recall a funny or memorable story involving your childhood heroes or role models.",
    "Share a moment when you felt a strong sense of gratitude or appreciation towards someone.",
    "Describe a time when you had to confront a personal bias or prejudice.",
    "What was your favorite childhood book or literary character and why?",
    "Recall a memorable experience you had while attending a sports event or competition.",
    "Share a funny or heartwarming story involving your grandparents or elderly relatives.",
    "What is the earliest childhood memory you can recall?",
    "Describe a life-changing event that had a profound impact on you.",
    "What was the most challenging obstacle you have faced in your life, and how did you overcome it?",
    "Share a significant accomplishment or milestone that you are proud of.",
    "Describe a person who has had a major influence on your life and explain why.",
    "What is the most valuable lesson you have learned from a difficult experience?",
    "Recall a time when you had to make a difficult decision that shaped the course of your life.",
    "Share a moment when you felt a deep sense of joy or happiness.",
    "What is the most meaningful relationship you have had in your life, and why is it important to you?",
    "Describe a time when you had to confront your fears and step outside of your comfort zone.",
    "What is a belief or value that has guided your actions and decisions throughout your life?",
    "Recall a moment when you experienced a profound act of kindness or generosity from someone.",
    "Share a significant turning point or crossroads in your life and the impact it had on you.",
    "Describe a time when you had to forgive someone or seek forgiveness, and what you learned from it.",
    "What is a personal or professional goal that you have achieved, and how did it shape your life?",
    "Recall a moment when you felt a deep sense of gratitude for the people or opportunities in your life.",
    "Share a transformative experience that broadened your perspective or changed your worldview.",
    "Describe a time when you had to overcome a major setback or failure and bounce back stronger.",
    "What is a significant sacrifice you have made for someone or something you believe in?",
    "Recall a moment when you had to stand up for your values or advocate for what is right.",
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
              Container(
                padding: EdgeInsets.all(
                    10.0), // Optional: Add padding to the container
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
                child: Text(
                  promptTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
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
