import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/src/features/authentication/controllers/menu_screen_controller.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MenusController menuController = Get.put(MenusController());
    return Scaffold(
      body: ListView.builder(
        itemCount: menuController.menuItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: menuController.menuItems[index].iconBackgroundColor,
                    borderRadius:
                        menuController.menuItems[index].iconBorderRadius,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    menuController.menuItems[index].icon,
                    color: menuController.menuItems[index].iconColor,
                  ),
                ),
                title: Text(
                  menuController.menuItems[index].title,
                  style: TextStyle(
                    color: menuController.menuItems[index].titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  menuController.menuItems[index].description,
                  style: TextStyle(
                    color: menuController.menuItems[index].descriptionColor,
                  ),
                ),
                onTap: () {
                  // Handle item tap here
                  menuController.menuItems[index].onTap();
                },
              ),
              Divider(),
            ],
          );
        },
      ),
    );
    // return ElevatedButton(
    //   onPressed: () {
    //     AuthController.instance.logout();
    //     AuthController.instance.email.text = "";
    //     AuthController.instance.password.text = "";
    //   },
    //   child: Text("Logout"),
    // );
  }
}
