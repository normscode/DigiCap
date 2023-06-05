import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_screen_controller.dart';
import '../../models/memory_model.dart';

class ViewFullMemoryScreen extends StatefulWidget {
  final MemoryModel memory;

  const ViewFullMemoryScreen({super.key, required this.memory});

  @override
  State<ViewFullMemoryScreen> createState() => _ViewFullMemoryScreenState();
}

class _ViewFullMemoryScreenState extends State<ViewFullMemoryScreen> {
  final player = AudioPlayer();
  bool playing = false;
  Duration duration = const Duration();
  Duration position = const Duration();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Full View'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                controller.formatTimeStamp(widget.memory.date!),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  width: 300,
                  child: Text(
                    widget.memory.title,
                    style:
                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                width: 300,
                child: Text(
                  widget.memory.description,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.ltr,
                  // Set indentation to 16.0
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                width: 300,
                child: Image.network(
                  widget.memory.photoURL ??
                      'https://firebasestorage.googleapis.com/v0/b/digiapp-721c2.appspot.com/o/digiapp%2Fundraw_moments_0y20.png?alt=media&token=110dfbf5-fe35-4d88-91b1-3b54096d8e78',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/error_image.png', // Replace with your error image asset path
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                width: 300,
                child: Column(
                  children: [
                    const Text(
                      'Voice Tag Story',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    voiceTagSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget voiceTagSection() {
    if (widget.memory.voiceTagURL != null) {
      return Column(
        children: [
          slider(),
          InkWell(
            onTap: () {
              getAudio();
            },
            child: Icon(
              playing == false
                  ? Icons.play_circle_outline
                  : Icons.pause_circle_outline,
              size: 50,
              color: Colors.orange,
            ),
          ),
        ],
      );
    } else {
      return const Text(
        'No Voice Tag found',
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
        ),
        textAlign: TextAlign.center,
      );
    }
  }

  Widget slider() {
    return Slider.adaptive(
        min: 0.0,
        value: position.inSeconds
            .toDouble()
            .clamp(0.0, duration.inSeconds.toDouble()),
        max: duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            player.seek(Duration(seconds: value.toInt()));
          });
        });
  }

  void getAudio() async {
    var url = widget.memory.voiceTagURL!;

    if (playing) {
      // Pause voice tag
      await player.pause();
      setState(() {
        playing = false;
      });
    } else {
      // Play voice tag
      await player.play(UrlSource(url));
      setState(() {
        playing = true;
      });
    }

    player.onDurationChanged.listen((Duration dd) {
      setState(() {
        duration = dd;
      });
    });
    player.onPositionChanged.listen((Duration dd) {
      setState(() {
        position = dd;
      });
    });
  }
}
