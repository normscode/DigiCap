import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
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
}
