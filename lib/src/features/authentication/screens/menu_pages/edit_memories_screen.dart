import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/add_memory_screen_controller.dart';
import '../../models/memory_model.dart';

class UpdateMemoryScreen extends StatefulWidget {
  final MemoryModel memory;

  UpdateMemoryScreen({required this.memory});

  @override
  _UpdateMemoryScreenState createState() => _UpdateMemoryScreenState();
}

class _UpdateMemoryScreenState extends State<UpdateMemoryScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final MemoryController memoryController = MemoryController();
  File? myImage;

  @override
  void initState() {
    super.initState();
    memoryController.title.text = widget.memory.title;
    memoryController.description.text = widget.memory.description;
    memoryController.date = widget.memory.date;
    memoryController.imageURL = widget.memory.photoURL!;
    memoryController.memoryID = widget.memory.id!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Memory'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: memoryController.title,
                        decoration: InputDecoration(
                          hintText: 'My Memory on ${DateTime.now().toString()}',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: memoryController.description,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Enter the description',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Photos',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                InkWell(
                  onTap: () {
                    openBottomSheet();
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: myImage == null
                        ? const Center(
                            child: Icon(
                              Icons.upload_file,
                              size: 50,
                            ),
                          )
                        : Image.file(
                            myImage!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      // If the form is valid, update the memory

                      // Handle save memory logic
                      await updateFile(memoryController.memoryID);

                      // Call the update memory function with widget.memory

                      Navigator.pop(context); // Go back to the previous screen
                    }
                  },
                  child: Text('Update Memory'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openBottomSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        width: double.infinity,
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BuildImageWidget(
                iconData: Icons.camera_alt,
                onPressed: () {
                  getImage(ImageSource.camera);
                }),
            BuildImageWidget(
                iconData: Icons.image,
                onPressed: () {
                  getImage(ImageSource.gallery);
                }),
          ],
        ),
      ),
    );
  }

  BuildImageWidget({required IconData iconData, required Function onPressed}) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(
            iconData,
            size: 30,
          ),
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      myImage = File(image.path);
      setState(() {});
      Get.back();
    }
  }

  Future<void> updateFile(String memoryID) async {
    if (myImage != null) {
      final file = myImage;
      final metaData = SettableMetadata(contentType: 'image/jpeg');
      final storageRef = FirebaseStorage.instance.ref();
      Reference ref = storageRef
          .child('memories/${DateTime.now().microsecondsSinceEpoch}.jpg');
      final uploadTask = ref.putFile(file!, metaData);

      uploadTask.snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            print("File is uploading");
            break;
          case TaskState.success:
            ref.getDownloadURL().then((value) => {print(value)});
            memoryController.imageURL = await ref.getDownloadURL();
            final memory = MemoryModel(
              title: memoryController.title.text.trim(),
              description: memoryController.description.text.trim(),
              date: memoryController.getCurrentFormattedDate(),
              photoURL: memoryController.imageURL.trim(),
            );
            memoryController.editMemories(memory, memoryController.memoryID);
            break;
          case TaskState.paused:
            print("File upload was paused");
            break;
          case TaskState.canceled:
            print("File upload was cancelled");
            break;
          case TaskState.error:
            print("File upload error!");
            break;
        }
      });
    } else {
      // Handle the case when no picture is selected
      final memory = MemoryModel(
        title: memoryController.title.text.trim(),
        description: memoryController.description.text.trim(),
        photoURL: memoryController.imageURL.trim(),
        date: memoryController.getCurrentFormattedDate(),
      );
      memoryController.editMemories(memory, memoryController.memoryID);
    }
  }
}
