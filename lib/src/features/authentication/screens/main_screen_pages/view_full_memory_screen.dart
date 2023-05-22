import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/memory_model.dart';

class ViewFullMemoryScreen extends StatelessWidget {
  final MemoryModel memory;

  const ViewFullMemoryScreen({required this.memory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Full Memory'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              memory.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              memory.description,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Image.network(
              memory.photoURL!,
              fit: BoxFit.contain,
              width: double.infinity,
              height: 200.0,
            ),
            SizedBox(height: 16.0),
            Text(
              memory.date!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement your edit functionality
              },
              child: Text('Edit Memory'),
            ),
          ],
        ),
      ),
    );
  }
}
