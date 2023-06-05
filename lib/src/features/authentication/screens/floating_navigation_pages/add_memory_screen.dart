// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_capsule/src/features/authentication/models/memory_model.dart';
import 'package:time_capsule/src/features/authentication/screens/main_screen.dart';
import '../../controllers/add_memory_screen_controller.dart';

class SaveMemoryScreen extends StatefulWidget {
  const SaveMemoryScreen({super.key});

  @override
  State<SaveMemoryScreen> createState() => _SaveMemoryScreenState();
}

class _SaveMemoryScreenState extends State<SaveMemoryScreen> {
  File? myImage;
  File? myAudio;

  final MemoryController memoryController = Get.put(MemoryController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Memory'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Title',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: memoryController.title,
                        decoration: InputDecoration(
                          hintText: 'My Memory on ${memoryController.formatTimeStamp(
                                  memoryController.getCurrentFormattedDate())}',
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.all(
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: memoryController.description,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Click here to write about this memory...',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Click here to write about this memory';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Photo',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text("Click Upload Icon Below to Add Photo"),
                      const SizedBox(height: 5.0),
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
                const SizedBox(height: 16.0),
                const Text(
                  'Voice Tag Story',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text("Click Upload Icon Below to Add Audio"),
                      const SizedBox(height: 5.0),
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
                              ? const Center(
                                  child: Icon(
                                    Icons.upload_file,
                                    size: 50,
                                  ),
                                )
                              : const Column(
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
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(
                          300, 50), // Set the width and height of the button
                      backgroundColor:
                          Colors.orange, // Set the background color to orange
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        // If the form is valid, save the memory
                        await uploadFile();
                        Get.to(() => const MainScreen());
                      }
                      // If the form is valid, save the memory

                      // Handle save memory logic
                    },
                    child: const Text(
                      'Save Memory',
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
        decoration: const BoxDecoration(
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

  Future<void> uploadFile() async {
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
                  createMemory();
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
            ref.getDownloadURL().then((value) => {print(value)});
            memoryController.imageURL = await ref.getDownloadURL();
            createMemoryImage();
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
            audioRef.getDownloadURL().then((audioValue) => print(audioValue));
            memoryController.audioURL = await audioRef.getDownloadURL();
            createMemoryAudio();
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
      // Handle the case when no picture is selected or No Audio File is Selected
      final memory = MemoryModel(
        title: memoryController.title.text.trim(),
        description: memoryController.description.text.trim(),
        date: memoryController.getCurrentFormattedDate(),
      );
      memoryController.createMemories(memory);
      memoryController.title.text = "";
      memoryController.description.text = "";
      memoryController.imageURL = "";
      memoryController.audioURL = "";
    }
  }

  createMemory() {
    final memory = MemoryModel(
      title: memoryController.title.text.trim(),
      description: memoryController.description.text.trim(),
      date: memoryController.getCurrentFormattedDate(),
      photoURL: memoryController.imageURL!.trim(),
      voiceTagURL: memoryController.audioURL!.trim(),
    );
    memoryController.createMemories(memory);
    memoryController.title.text = "";
    memoryController.description.text = "";
    memoryController.imageURL = "";
    memoryController.audioURL = "";
  }

  createMemoryImage() {
    final memory = MemoryModel(
      title: memoryController.title.text.trim(),
      description: memoryController.description.text.trim(),
      date: memoryController.getCurrentFormattedDate(),
      photoURL: memoryController.imageURL!.trim(),
    );
    memoryController.createMemories(memory);
    memoryController.title.text = "";
    memoryController.description.text = "";
    memoryController.imageURL = "";
    memoryController.audioURL = "";
  }

  createMemoryAudio() {
    final memory = MemoryModel(
      title: memoryController.title.text.trim(),
      description: memoryController.description.text.trim(),
      date: memoryController.getCurrentFormattedDate(),
      voiceTagURL: memoryController.audioURL!.trim(),
    );
    memoryController.createMemories(memory);
    memoryController.title.text = "";
    memoryController.description.text = "";
    memoryController.imageURL = "";
    memoryController.audioURL = "";
  }
}
