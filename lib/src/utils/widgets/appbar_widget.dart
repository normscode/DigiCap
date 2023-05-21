import 'package:flutter/material.dart';

class mainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const mainAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange,
      leading: Padding(
        padding: EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/logo/logo.png', // Replace with your own logo image path
          width: 24,
          height: 24,
        ),
      ),
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for anything...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.search,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
