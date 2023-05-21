import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/main_screen_controller.dart';

class NewsFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainScreenController controller = Get.put(MainScreenController());
    return Scaffold(
      appBar: AppBar(title: Text("NewsFeed")),
      body: Center(child: Text("NewsFeed")),
    );
  }
}
