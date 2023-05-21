import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen_pages/home_screen.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen_pages/menu_screen.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen_pages/notifications_screen.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen_pages/tools_screen.dart';
import '../../../utils/widgets/appbar_widget.dart';
import '../controllers/main_screen_controller.dart';
import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';

import 'floating_navigation_pages/add_memory_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    ToolScreen(),
    NotificationScreen(),
    MenuScreen(),
  ];

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    final MainScreenController controller = Get.put(MainScreenController());
    return Scaffold(
      appBar: mainAppBar(),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      // body: Obx(
      //     () => controller.menuItems[controller.currentPageIndex.value].page),
      // floatingActionButton: mainFloatingActionButton(),
      // bottomNavigationBar: BottomNavigationBarWidget(),

      floatingActionButton: FloatingActionBubble(
        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPressed: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),

        // Floating Action button Icon color
        iconColor: Colors.blue,

        // Floating Action button Icon
        iconData: Icons.ac_unit,
        backgroundColor: Colors.white,
        // Menu items
        items: <Widget>[
          // Floating action menu item
          BubbleMenu(
            title: "New Group",
            iconColor: Colors.white,
            bubbleColor: Colors.orange,
            icon: Icons.group_add,
            style: const TextStyle(fontSize: 14, color: Colors.white),
            onPressed: () {
              _animationController.reverse();
            },
          ),
          // Floating action menu item
          BubbleMenu(
            title: "Upload Photos",
            iconColor: Colors.white,
            bubbleColor: Colors.orange,
            icon: Icons.photo,
            style: const TextStyle(fontSize: 13, color: Colors.white),
            onPressed: () {
              _animationController.reverse();
            },
          ),
          //Floating action menu item
          BubbleMenu(
            title: "Add Memory",
            iconColor: Colors.white,
            bubbleColor: Colors.orange,
            icon: Icons.event,
            style: const TextStyle(fontSize: 14, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SaveMemoryScreen(),
                ),
              );
              _animationController.reverse();
            },
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.black87,
      //   foregroundColor: Colors.yellow,
      //   shape: CircleBorder(),
      // ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.orange : Colors.grey,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                              color: currentTab == 0
                                  ? Colors.orange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ToolScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.build,
                          color: currentTab == 1 ? Colors.orange : Colors.grey,
                        ),
                        Text(
                          "Tools",
                          style: TextStyle(
                              color: currentTab == 1
                                  ? Colors.orange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = NotificationScreen();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications,
                          color: currentTab == 2 ? Colors.orange : Colors.grey,
                        ),
                        Text(
                          "Notifications",
                          style: TextStyle(
                              color: currentTab == 2
                                  ? Colors.orange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = MenuScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu,
                          color: currentTab == 3 ? Colors.orange : Colors.grey,
                        ),
                        Text(
                          "Tools",
                          style: TextStyle(
                              color: currentTab == 3
                                  ? Colors.orange
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
