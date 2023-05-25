import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_capsule/src/features/authentication/models/memory_model.dart';

class MemoriesRepository extends GetxController {
  static MemoriesRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Add Memories Method
  addMemories(MemoryModel memory) {
    final userEmail = _auth.currentUser!.email;
    _db
        .collection("Users")
        .doc(userEmail)
        .collection("Memories")
        .add(memory.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your Memory has been added!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  //Get User Data Memories From Firestore
  Stream<List<MemoryModel>> fetchCurrentUserMemories() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    return FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email)
        .collection('Memories')
        .orderBy('Date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return MemoryModel(
                id: doc.id,
                title: data['Title'],
                description: data['Description'],
                date: data['Date'],
                photoURL: data['PhotoURL'],
              );
            }).toList());
  }

  //Update User Data Memories From Firestore
  Future<void> updateMemory(MemoryModel memory, String memoryID) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    final memoryRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email)
        .collection('Memories')
        .doc(memoryID); // Assuming 'id' is the document ID of the memory

    await memoryRef.update({
      'Title': memory.title,
      'Description': memory.description,
      'Date': memory.date,
      'PhotoURL': memory.photoURL,
    });
  }

  //Delete Method for Memories
  Future<void> deleteMemory(String memoryID) async {
    await _db
        .collection("Users")
        .doc(_auth.currentUser!.email)
        .collection("Memories")
        .doc(memoryID)
        .delete();

    Get.snackbar("Memory Deleted!", 'You have successfully deleted a memory');
  }
}
