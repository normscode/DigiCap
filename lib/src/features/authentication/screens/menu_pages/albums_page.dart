import 'package:flutter/material.dart';

class AlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Albums")),
      body: Center(child: Text("All your Pictures")),
    );
  }
}
