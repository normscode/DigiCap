import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/src/repository/user_memories_repository.dart';
import '../models/memory_model.dart';
import 'package:intl/intl.dart';

class MemoryController extends GetxController {
  File? myImage;
  static MemoryController get instance => Get.find();
  final title = TextEditingController();
  final description = TextEditingController();
  final photoURL = TextEditingController();
  Timestamp? date;
  String? audioURL;
  String? imageURL;
  final memoryRepo = Get.put(MemoriesRepository());

  String memoryID = "";

  //Photos Fields

  //Add Memory
  Future<void> createMemories(MemoryModel memory) async {
    await memoryRepo.addMemories(memory);
  }

  //Update Memory
  Future<void> editMemories(MemoryModel memory, String memoryID) async {
    await memoryRepo.updateMemory(memory, memoryID);
  }

  //Delete Memory

  Future<void> deleteMemories(String memoryID) async {
    await memoryRepo.deleteMemory(memoryID);
  }

  Timestamp getCurrentFormattedDate() {
    DateTime now = DateTime.now();
    return Timestamp.fromDate(now);
  }

  String formatTimeStamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('d MMM y').format(dateTime);
    return formattedDate;
  }

  //Delete Memory Image from Firebase Storage memories
  Future<void> deletePhotoMemory(String photoURL) async {
    await memoryRepo.deleteImage(photoURL);
  }

  Future<void> deleteAudioMemory(String audioURL) async {
    await memoryRepo.deleteAudio(audioURL);
  }
}
