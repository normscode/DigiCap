import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/src/features/authentication/controllers/main_screen_controller.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  // final BottomNavigationController controller =
  //     Get.put(BottomNavigationController());
  final MainScreenController controller = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          currentIndex: controller.currentPageIndex.value,
          onTap: controller.changePage,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey.withOpacity(1),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: 'Tools',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        ));
  }
}
