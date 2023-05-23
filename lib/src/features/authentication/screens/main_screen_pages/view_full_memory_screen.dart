import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/add_memory_screen.controller.dart';
import '../../controllers/home_screen_controller.dart';
import '../../models/memory_model.dart';

class ViewFullMemoryScreen extends StatelessWidget {
  final MemoryModel memory;

  const ViewFullMemoryScreen({required this.memory});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Full View'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Offset
                    ),
                  ],
                ),
                width: 300,
                padding: EdgeInsets.all(10),
                child: Text(
                  memory.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Offset
                    ),
                  ],
                ),
                width: 300,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Text(
                    memory.description,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.ltr,
                    // Set indentation to 16.0
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Offset
                    ),
                  ],
                ),
                width: 300,
                height: 300,
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Image.network(
                    memory.photoURL ??
                        'https://firebasestorage.googleapis.com/v0/b/digiapp-721c2.appspot.com/o/memories%2Fundraw_moments_0y20.png?alt=media&token=fd302635-248b-43bc-8bca-4348de001339',
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
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              controller.formatTimeStamp(memory.date!),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
