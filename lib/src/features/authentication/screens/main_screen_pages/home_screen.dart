import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:time_capsule/src/features/authentication/controllers/home_screen_controller.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen_pages/view_full_memory_screen.dart';
import 'package:time_capsule/src/utils/widgets/appbar_widget.dart';

import '../../models/memory_model.dart';
import '../../models/user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.hasData) {
              final List<MemoryModel> memories = snapshot.data!;

              if (memories.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      UnDraw(
                        height: 150,
                        width: 150,
                        color: Colors.blue,
                        illustration: UnDrawIllustration.moments,
                        placeholder: Container(),
                        errorWidget: Icon(Icons.error_outline,
                            color: Colors.red, size: 50),
                      ),
                      Text("No memories found"),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: memories.length,
                  itemBuilder: (context, index) {
                    final MemoryModel memory = memories[index];
                    String timeDuration =
                        controller.formatTimeDuration(memory.date!);
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24.0,
                                  backgroundImage: AssetImage(
                                      "assets/images/profile-empty.png"),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        memory.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                        memory.description,
                                        style: TextStyle(fontSize: 14.0),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        timeDuration,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Image.network(
                              memory.photoURL ??
                                  'https://firebasestorage.googleapis.com/v0/b/digiapp-721c2.appspot.com/o/digiapp%2Fundraw_moments_0y20.png?alt=media&token=110dfbf5-fe35-4d88-91b1-3b54096d8e78',
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/error_image.png', // Replace with your error image asset path
                                  fit: BoxFit.cover,
                                );
                              },
                              fit: BoxFit.cover,
                              height: 200,
                              width: 300,
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              controller.formatTimeStamp(memory.date!),
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
              }
            } else {
              return Center(child: Text('No memories found.'));
            }
          },
        ),
      ),
    );
  }

  //Date Formatting
}
