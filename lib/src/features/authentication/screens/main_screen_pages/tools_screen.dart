import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen.dart';
import '../menu_pages/albums_page.dart';
import '../menu_pages/manage_memories_page.dart';

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
            toolName: 'News Feed',
            iconData: Icons.home,
            iconBackgroundColor: const Color.fromARGB(255, 0, 26, 71),
            iconColor: Colors.white,
            titleColor: Colors.orange,
            onTap: () {
              // Handle tool selection for News Feed
              Get.offAll(() => MainScreen());
            },
          ),
          ToolCard(
            toolName: 'Memories',
            iconData: FontAwesomeIcons.heartCircleCheck,
            iconBackgroundColor: const Color.fromARGB(255, 17, 90, 150),
            iconColor: Colors.white,
            titleColor: Colors.orange,
            onTap: () {
              // Handle tool selection for Memories
              Get.to(() => MemoriesPage());
            },
          ),
          ToolCard(
            toolName: 'Photos',
            iconData: Icons.camera_alt,
            iconBackgroundColor: Color.fromARGB(255, 71, 0, 36),
            iconColor: Colors.white,
            titleColor: Colors.orange,
            onTap: () {
              // Handle tool selection for Photos
              Get.to(() => AlbumPage());
            },
          ),
          ToolCard(
            toolName: 'Groups',
            iconData: Icons.group_add,
            iconBackgroundColor: Color.fromARGB(255, 85, 0, 85),
            iconColor: Colors.white,
            titleColor: Colors.orange,
            onTap: () {
              // Handle tool selection for Photos
            },
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
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color titleColor;
  final VoidCallback onTap;

  const ToolCard({
    required this.toolName,
    required this.iconData,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.titleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: iconBackgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 48.0,
              color: iconColor,
            ),
            SizedBox(height: 8.0),
            Text(
              toolName,
              style: TextStyle(fontSize: 16.0, color: titleColor),
            ),
          ],
        ),
      ),
    );
  }
}
