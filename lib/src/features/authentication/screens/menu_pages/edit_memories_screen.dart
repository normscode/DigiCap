import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
  File? myAudio;

  @override
  void initState() {
    super.initState();
    memoryController.title.text = widget.memory.title;
    memoryController.description.text = widget.memory.description;
    memoryController.date = widget.memory.date;
    memoryController.imageURL = widget.memory.photoURL;
    memoryController.memoryID = widget.memory.id!;
    memoryController.audioURL = widget.memory.voiceTagURL;
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
                Container(
                  width: 500,
                  padding: EdgeInsets.all(
                      10.0), // Optional: Add padding to the container
                  decoration: BoxDecoration(
                    // Optional: Add decoration properties to the container
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
                    children: [
                      Text("Click Upload Icon Below to Replace Photo"),
                      SizedBox(height: 5.0),
                      InkWell(
                        onTap: () {
                          openBottomSheet();
                        },
                        child: Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
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
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Voice Tag Story',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: 500,
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
                    children: [
                      Text("Click Upload Icon Below to Add Audio"),
                      SizedBox(height: 5.0),
                      InkWell(
                        onTap: () {
                          getAudio();
                        },
                        child: Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: myAudio == null
                              ? Center(
                                  child: Icon(
                                    Icons.upload_file,
                                    size: 50,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.music_note,
                                      size: 50,
                                    ),
                                    Text(
                                      'Audio Selected',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                          300, 50), // Set the width and height of the button
                      backgroundColor:
                          Colors.orange, // Set the background color to orange
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        // If the form is valid, update the memory

                        // Handle save memory logic

                        await updateFile(memoryController.memoryID);

                        // Call the update memory function with widget.memory

                        Navigator.pop(
                            context); // Go back to the previous screen
                      }
                    },
                    child: Text(
                      'Update Memory',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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

  getAudio() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null) {
      myAudio = File(result.files.single.path!);
      setState(() {});
    }
  }

  Future<void> updateFile(String memoryID) async {
    if (myAudio != null && myImage != null) {
      final audioFile = myAudio;
      final audioMetaData = SettableMetadata(contentType: 'audio/mpeg');
      final storageRef = FirebaseStorage.instance.ref();
      Reference audioRef = storageRef
          .child('voicetags/${DateTime.now().microsecondsSinceEpoch}.mp3');
      final audioUploadTask = audioRef.putFile(audioFile!, audioMetaData);

      audioUploadTask.snapshotEvents.listen((audioEvent) async {
        switch (audioEvent.state) {
          case TaskState.running:
            print("Audio file is uploading");
            break;
          case TaskState.success:
            memoryController.deletePhotoMemory(memoryController.imageURL!);
            memoryController.deleteAudioMemory(memoryController.audioURL!);
            audioRef.getDownloadURL().then((audioValue) => print(audioValue));
            memoryController.audioURL = await audioRef.getDownloadURL();
            final imageFile = myImage!;
            final imageMetaData = SettableMetadata(contentType: 'image/jpeg');
            Reference imageRef = storageRef
                .child('memories/${DateTime.now().microsecondsSinceEpoch}.jpg');
            final imageUploadTask = imageRef.putFile(imageFile, imageMetaData);

            imageUploadTask.snapshotEvents.listen((imageEvent) async {
              switch (imageEvent.state) {
                case TaskState.running:
                  print("Image file is uploading");
                  break;
                case TaskState.success:
                  imageRef
                      .getDownloadURL()
                      .then((imageValue) => print(imageValue));
                  memoryController.imageURL = await imageRef.getDownloadURL();
                  updateMemory();
                  break;
                case TaskState.paused:
                  print("Image file upload was paused");
                  break;
                case TaskState.canceled:
                  print("Image file upload was cancelled");
                  break;
                case TaskState.error:
                  print("Image file upload error!");
                  break;
              }
            });
            break;
          case TaskState.paused:
            print("Audio file upload was paused");
            break;
          case TaskState.canceled:
            print("Audio file upload was cancelled");
            break;
          case TaskState.error:
            print("Audio file upload error!");
            break;
        }
      });
    } else if (myImage != null) {
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
            if (memoryController.imageURL != null) {
              memoryController.deletePhotoMemory(memoryController.imageURL!);
            }
            ref.getDownloadURL().then((value) => {print(value)});
            memoryController.imageURL = await ref.getDownloadURL();
            updateMemory();
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
    } else if (myAudio != null) {
      final audioFile = myAudio;
      final audioMetaData = SettableMetadata(contentType: 'audio/mpeg');
      final storageRef = FirebaseStorage.instance.ref();
      Reference audioRef = storageRef
          .child('voicetags/${DateTime.now().microsecondsSinceEpoch}.mp3');
      final audioUploadTask = audioRef.putFile(audioFile!, audioMetaData);

      audioUploadTask.snapshotEvents.listen((audioEvent) async {
        switch (audioEvent.state) {
          case TaskState.running:
            print("Audio file is uploading");
            break;
          case TaskState.success:
            if (memoryController.audioURL != null) {
              memoryController.deleteAudioMemory(memoryController.audioURL!);
            }
            audioRef.getDownloadURL().then((audioValue) => print(audioValue));
            memoryController.audioURL = await audioRef.getDownloadURL();
            updateMemory();
            break;
          case TaskState.paused:
            print("Audio file upload was paused");
            break;
          case TaskState.canceled:
            print("Audio file upload was cancelled");
            break;
          case TaskState.error:
            print("Audio file upload error!");
            break;
        }
      });
    } else {
      // Handle the case when no picture is selected and audio is null
      updateMemory();
    }
  }

  updateMemory() {
    final memory = MemoryModel(
      title: memoryController.title.text.trim(),
      description: memoryController.description.text.trim(),
      photoURL: memoryController.imageURL?.trim() ?? '',
      date: memoryController.getCurrentFormattedDate(),
      voiceTagURL: memoryController.audioURL?.trim() ?? '',
    );
    memoryController.editMemories(memory, memoryController.memoryID);
  }
}
