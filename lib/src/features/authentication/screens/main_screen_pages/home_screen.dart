import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/src/features/authentication/controllers/home_screen_controller.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen_pages/view_full_memory_screen.dart';
import 'package:time_capsule/src/utils/widgets/appbar_widget.dart';

import '../../models/memory_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String getTimeDuration(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  void navigateToViewFullMemory(MemoryModel memory) {
    Get.to(() => ViewFullMemoryScreen(memory: memory));
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      body: Container(
        child: StreamBuilder<List<MemoryModel>>(
          stream: controller.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final List<MemoryModel> memories = snapshot.data!;

            return ListView.builder(
              itemCount: memories.length,
              itemBuilder: (context, index) {
                final MemoryModel memory = memories[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24.0,
                              backgroundImage: NetworkImage(
                                  "https://th.bing.com/th/id/R.782adc2b6062ab00461359da5b02b753?rik=Y%2fJZM98TPsfXxA&riu=http%3a%2f%2fwww.pngall.com%2fwp-content%2fuploads%2f5%2fProfile-PNG-File.png&ehk=nJ0Yls4aiMdSvREO5hB2GU7Hc3cL04UQeojwLhvL8Gk%3d&risl=&pid=ImgRaw&r=0"),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    memory.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    memory.description,
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Image.network(
                          memory.photoURL ?? '',
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          memory.date ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () {
                              // Navigate to the Full Memory Screen to view/edit the memory
                              navigateToViewFullMemory(memory);
                            },
                            icon: Icon(Icons.open_in_new),
                            label: Text('View Full Memory'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
