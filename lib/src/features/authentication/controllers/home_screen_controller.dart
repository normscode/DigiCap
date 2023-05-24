import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_capsule/src/features/authentication/controllers/authentication_controller.dart';

import '../../../repository/user_memories_repository.dart';

class HomeScreenController extends GetxController {
  final _authRepo = Get.put(AuthController());
  final _memoryRepo = Get.put(MemoriesRepository());

  final _auth = FirebaseAuth.instance;
  getUserData() {
    final email = _auth.currentUser?.email;
    if (email != null) {
      return _memoryRepo.fetchCurrentUserMemories();
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }

  //Date Formatting
  String formatTimeStamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('d MMM y').format(dateTime);
    return formattedDate;
  }

  String formatTimeDuration(Timestamp timestamp) {
    DateTime memoryDateTime = timestamp.toDate();
    DateTime currentDateTime = DateTime.now();
    Duration duration = currentDateTime.difference(memoryDateTime);

    // Calculate the time duration in years, months, days, hours, minutes, and seconds
    int years = duration.inDays ~/ 365;
    int months = (duration.inDays % 365) ~/ 30;
    int days = (duration.inDays % 30);
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    // Create the formatted time duration string
    String formattedDuration = '';

    // Format the time duration based on different time units
    if (years > 0) {
      formattedDuration += '${years}y ';
    } else if (months > 0) {
      formattedDuration += '${months}mo ';
    } else if (days > 0) {
      formattedDuration += '${days}d ';
    } else if (hours > 0) {
      formattedDuration += '${hours}h ';
    } else if (minutes > 0) {
      formattedDuration += '${minutes}m ';
    } else if (seconds > 0) {
      formattedDuration += '${seconds}s';
    } else {
      formattedDuration = 'Just now';
    }

    return formattedDuration.trim();
  }
}
