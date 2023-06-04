import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen_pages/home_screen.dart';
import 'package:time_capsule/src/features/authentication/screens/menu_pages/edit_profile_screen.dart';

import '../screens/menu_pages/albums_page.dart';
import '../screens/menu_pages/manage_memories_page.dart';

import 'authentication_controller.dart';

class MenusController extends GetxController {
  static MenusController get instance => Get.find();
  final List<ListItem> menuItems = [
    ListItem(
      icon: Icons.rss_feed,
      title: "News Feed",
      description: 'Browse latest activity',
      iconBackgroundColor: const Color.fromARGB(255, 0, 26, 71),
      iconColor: Colors.white,
      titleColor: Colors.orange,
      descriptionColor: Colors.black.withOpacity(0.3),
      iconBorderRadius: BorderRadius.circular(10),
      page: MainScreen(),
      onTap: () {
        Get.offAll(() => MainScreen());
        debugPrint("NewsPageTapped!");
      },
    ),
    ListItem(
      icon: Icons.notes,
      title: 'Manage Memories',
      description: 'View all of your Memories on DigiCap',
      iconBackgroundColor: Colors.blue,
      iconColor: Colors.white,
      titleColor: Colors.orange,
      descriptionColor: Colors.black.withOpacity(0.3),
      iconBorderRadius: BorderRadius.circular(10),
      page: MemoriesPage(),
      onTap: () {
        Get.to(() => MemoriesPage());
        debugPrint("ManageMemoriesTapped!");
      },
    ),
    ListItem(
      icon: Icons.album,
      title: 'Album',
      description: 'Explore photo albums',
      iconBackgroundColor: Colors.orange,
      iconColor: Colors.white,
      titleColor: Colors.orange,
      descriptionColor: Colors.black.withOpacity(0.3),
      iconBorderRadius: BorderRadius.circular(10),
      page: AlbumPage(),
      onTap: () {
        Get.to(() => AlbumPage());
      },
    ),
    ListItem(
      icon: Icons.person,
      title: 'Profile',
      description: 'View and Edit your profile',
      iconBackgroundColor: Color.fromARGB(255, 56, 177, 0),
      iconColor: Colors.white,
      titleColor: Colors.orange,
      descriptionColor: Colors.black.withOpacity(0.3),
      iconBorderRadius: BorderRadius.circular(10),
      page: EditProfileScreen(),
      onTap: () {
        Get.to(() => EditProfileScreen());
      },
    ),
    ListItem(
      icon: Icons.logout,
      title: 'Logout',
      description: 'Logout from DigiCap',
      iconBackgroundColor: Color.fromARGB(255, 226, 185, 0),
      iconColor: Colors.white,
      titleColor: Colors.orange,
      descriptionColor: Colors.black.withOpacity(0.3),
      iconBorderRadius: BorderRadius.circular(10),
      page: null,
      onTap: () {
        AuthController.instance.logout();
        AuthController.instance.email.text = "";
        AuthController.instance.password.text = "";
        AuthController.instance.fullName.text = "";
        AuthController.instance.confirmPassword.text = "";
      },
    ),
  ];
}

class ListItem {
  final IconData icon;
  final String title;
  final String description;
  final Color iconColor;
  final Color iconBackgroundColor;
  final BorderRadius iconBorderRadius;
  final Color titleColor;
  final Color descriptionColor;
  final Function onTap;
  final Widget? page;

  ListItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.iconBorderRadius,
    required this.titleColor,
    required this.descriptionColor,
    required this.page,
    required this.onTap,
  });
}
