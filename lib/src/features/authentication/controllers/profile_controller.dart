import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_capsule/src/features/authentication/controllers/authentication_controller.dart';
import 'package:time_capsule/src/repository/user_repository.dart';

import '../models/user_model.dart';

class ProfileController extends GetxController {
  final userRepo = Get.put(UserRepository());
  final auth = Get.put(AuthController());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  String formatTimeStamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('d MMM y').format(dateTime);
    return formattedDate;
  }

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
  }
  updatePassword(UserModel user)async {
    await _userRepo.updateUserPassword(user);
  }

}
