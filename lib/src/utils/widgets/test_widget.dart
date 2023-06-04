import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Container(
        //   child: Padding(
        //     padding: EdgeInsets.all(30.0),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Center(
        //           child: Container(
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               boxShadow: [
        //                 BoxShadow(
        //                   color: Colors.grey.withOpacity(0.5), // Shadow color
        //                   spreadRadius: 2, // Spread radius
        //                   blurRadius: 5, // Blur radius
        //                   offset: Offset(0, 3), // Offset
        //                 ),
        //               ],
        //             ),
        //             width: 300,
        //             padding: EdgeInsets.all(10),
        //             child: Text(
        //               widget.memory.title,
        //               style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 24.0,
        //               ),
        //               textAlign: TextAlign.center,
        //             ),
        //           ),
        //         ),
        //         SizedBox(height: 16.0),
        //         Expanded(
        //           child: Container(
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               boxShadow: [
        //                 BoxShadow(
        //                   color: Colors.grey.withOpacity(0.5), // Shadow color
        //                   spreadRadius: 2, // Spread radius
        //                   blurRadius: 5, // Blur radius
        //                   offset: Offset(0, 3), // Offset
        //                 ),
        //               ],
        //             ),
        //             width: 300,
        //             padding: EdgeInsets.all(10),
        //             alignment: Alignment.center,
        //             child: SingleChildScrollView(
        //               child: Text(
        //                 widget.memory.description,
        //                 style: TextStyle(
        //                   fontSize: 18.0,
        //                 ),
        //                 textAlign: TextAlign.justify,
        //                 textDirection: TextDirection.ltr,
        //                 // Set indentation to 16.0
        //               ),
        //             ),
        //           ),
        //         ),
        //         SizedBox(height: 16.0),
        //         Center(
        //           child: Container(
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               boxShadow: [
        //                 BoxShadow(
        //                   color: Colors.grey.withOpacity(0.5), // Shadow color
        //                   spreadRadius: 2, // Spread radius
        //                   blurRadius: 5, // Blur radius
        //                   offset: Offset(0, 3), // Offset
        //                 ),
        //               ],
        //             ),
        //             width: 300,
        //             height: 300,
        //             padding: EdgeInsets.all(10),
        //             child: SingleChildScrollView(
        //               child: Image.network(
        //                 widget.memory.photoURL ??
        //                     'https://firebasestorage.googleapis.com/v0/b/digiapp-721c2.appspot.com/o/digiapp%2Fundraw_moments_0y20.png?alt=media&token=110dfbf5-fe35-4d88-91b1-3b54096d8e78',
        //                 fit: BoxFit.cover,
        //                 width: double.infinity,
        //                 errorBuilder: (context, error, stackTrace) {
        //                   return Image.asset(
        //                     'assets/images/error_image.png', // Replace with your error image asset path
        //                     fit: BoxFit.cover,
        //                   );
        //                 },
        //               ),
        //             ),
        //           ),
        //         ),
        //         SizedBox(height: 16.0),
        //         Text(
        //           controller.formatTimeStamp(widget.memory.date!),
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 16.0,
        //             color: Colors.grey,
        //           ),
        //           textAlign: TextAlign.center,
        //         ),
        //         SizedBox(height: 16.0),
        //         // Center(
        //         //   child: Container(
        //         //     decoration: BoxDecoration(
        //         //       color: Colors.white,
        //         //       boxShadow: [
        //         //         BoxShadow(
        //         //           color: Colors.grey.withOpacity(0.5), // Shadow color
        //         //           spreadRadius: 2, // Spread radius
        //         //           blurRadius: 5, // Blur radius
        //         //           offset: Offset(0, 3), // Offset
        //         //         ),
        //         //       ],
        //         //     ),
        //         //     width: 300,
        //         //     padding: EdgeInsets.all(10),
        //         //     child: Column(
        //         //       children: [
        //         //         Text(
        //         //           'Voice Tag Story',
        //         //           style: TextStyle(
        //         //             fontWeight: FontWeight.bold,
        //         //             fontSize: 16.0,
        //         //           ),
        //         //           textAlign: TextAlign.center,
        //         //         ),
        //         //         slider(),
        //         //         InkWell(
        //         //           onTap: () {
        //         //             getAudio();
        //         //           },
        //         //           child: Icon(
        //         //             playing == false
        //         //                 ? Icons.play_circle_outline
        //         //                 : Icons.pause_circle_outline,
        //         //             size: 50,
        //         //             color: Colors.orange,
        //         //           ),
        //         //         ),
        //         //       ],
        //         //     ),
        //         //   ),
        //         // ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
