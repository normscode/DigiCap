import 'dart:io';

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
  String imageURL = "";
  final memoryRepo = Get.put(MemoriesRepository());

  //Photos Fields

  Future<void> createMemories(MemoryModel memory) async {
    await memoryRepo.addMemories(memory);
  }

  String getCurrentFormattedDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM y').format(now);
    return formattedDate;
  }
}
