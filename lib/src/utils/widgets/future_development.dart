import 'package:flutter/material.dart';

class ToBeDevelopedScreen extends StatelessWidget {
  const ToBeDevelopedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Be Developed'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 100,
              color: Colors.orange,
            ),
            SizedBox(height: 16),
            Text(
              'This feature is currently under development.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
