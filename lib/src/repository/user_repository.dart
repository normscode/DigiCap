import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  createUser(UserModel user) async {
    await _db
        .collection("Users")
        .doc(user.email)
        .set(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    });
  }

  //Step 2 - Fetch All Users or User Details
  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> getAllUser(String email) async {
    final snapshot = await _db.collection("Users").get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUserPassword(UserModel user) async {
    await _auth.currentUser?.updatePassword(user.password).whenComplete(
          () => Get.snackbar(
            "Success",
            "Your password has been updated.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          ),
        );
  }

  Future<void> updateUserRecord(UserModel user) async {
    // await _db
    //     .collection("Users")
    //     .doc(user.email)
    //     .update(user.toJson())
    //     .whenComplete(
    //       () => Get.snackbar("Success", "Your account data has been updated.",
    //           snackPosition: SnackPosition.BOTTOM,
    //           backgroundColor: Colors.green.withOpacity(0.1),
    //           colorText: Colors.green),
    //     );
    try {
      await _db
          .collection("Users")
          .doc(user.email)
          .update(user.toJson())
          .whenComplete(() {
        Get.snackbar(
          "Success",
          "Your account data has been updated.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      });
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to update account data: $error",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}
