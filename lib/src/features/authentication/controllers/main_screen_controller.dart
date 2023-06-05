import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen_pages/home_screen.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen_pages/menu_screen.dart';
import '../screens/main_screen_pages/reminders_screen.dart';
import '../screens/main_screen_pages/tools_screen.dart';

class MainScreenController extends GetxController {
  MainScreenController get instance => Get.find();
  RxInt currentPageIndex = 0.obs;

  final List<ListItem> menuItems = [
    ListItem(
      label: 'Home',
      icon: Icons.home,
      page: const HomeScreen(),
    ),
    ListItem(
      label: 'Tools',
      icon: Icons.build,
      page: const ToolScreen(),
    ),
    ListItem(
      label: 'Notifications',
      icon: Icons.notifications,
      page: const ReminderScreen(),
    ),
    ListItem(
      label: 'Menu',
      icon: Icons.menu,
      page: const MenuScreen(),
    ),
  ];

  void changePage(int index) {
    currentPageIndex.value = index;
  }
}

class ListItem {
  final IconData icon;
  final String label;
  final Widget page;

  ListItem({
    required this.icon,
    required this.label,
    required this.page,
  });
}
