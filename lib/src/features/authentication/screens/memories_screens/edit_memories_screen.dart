// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class EditMemoryScreen extends StatelessWidget {
//   final MemoryController memoryController = Get.put(MemoryController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Memory'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Title',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               TextFormField(
//                 controller: memoryController.title,
//                 decoration: InputDecoration(
//                   hintText: 'My Memory on ' +
//                       memoryController.getCurrentFormattedDate(),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'Description',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               TextFormField(
//                 controller: memoryController.description,
//                 maxLines: 4,
//                 decoration: InputDecoration(
//                   hintText: 'Enter the description',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 'Photos',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               InkWell(
//                 onTap: () {
//                   openBottomSheet();
//                 },
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black),
//                       borderRadius: BorderRadius.circular(8)),
//                   child: myImage == null
//                       ? const Center(
//                           child: Icon(
//                             Icons.upload_file,
//                             size: 50,
//                           ),
//                         )
//                       : Image.file(
//                           myImage!,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               ),
//               // Implement your photo selection/capture widget here
//               SizedBox(height: 16.0),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   // Handle update memory logic
//                   await uploadFile();
//                   memoryController
//                       .updateMemory(); // Call the update method in the controller

//                   Get.back(); // Navigate back to the previous screen
//                 },
//                 child: Text('Save Memory'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
