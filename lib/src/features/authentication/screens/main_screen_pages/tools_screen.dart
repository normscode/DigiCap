import 'package:flutter/material.dart';

class ToolScreen extends StatelessWidget {
  const ToolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        padding: EdgeInsets.all(16.0),
        crossAxisSpacing: 16.0, // Spacing between columns
        mainAxisSpacing: 16.0, // Spacing between rows
        children: [
          ToolCard(
            toolName: 'Tool 1',
            iconData: Icons.accessibility,
          ),
          ToolCard(
            toolName: 'Tool 2',
            iconData: Icons.camera_alt,
          ),
          // Add more ToolCard widgets for each tool
        ],
      ),
    );
  }
}

class ToolCard extends StatelessWidget {
  final String toolName;
  final IconData iconData;

  const ToolCard({
    required this.toolName,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Handle tool selection
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 48.0,
            ),
            SizedBox(height: 8.0),
            Text(
              toolName,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
