import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';

class mainFloatingActionButton extends StatelessWidget {
  const mainFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      Positioned(
        bottom: 2.0,
        left: 170.0,
        child: AnimatedFloatingActionButton(
          fabButtons: <Widget>[
            // Add new memory option
            FloatingActionButton(
              shape: CircleBorder(),
              onPressed: () {
                // Add your logic for adding a new memory
              },
              heroTag: 'add_memory',
              tooltip: 'Add Memory',
              child: Icon(Icons.add),
            ),
            // Upload photos option
            FloatingActionButton(
              shape: CircleBorder(),
              onPressed: () {
                // Add your logic for uploading photos
              },
              heroTag: 'upload_photos',
              tooltip: 'Upload Photos',
              child: Icon(Icons.cloud_upload),
            ),
          ],
          colorStartAnimation: Colors.orange,
          colorEndAnimation: Colors.pink,
          animatedIconData: AnimatedIcons.view_list,
        ),
      )
    ]);
    // return FloatingActionButton(
    //   onPressed: () {

    //   },
    //   child: Icon(Icons.add),
    //   shape: CircleBorder(),
    //   backgroundColor: Colors.orange,
    //   foregroundColor: Colors.white,
    // );
  }
}
