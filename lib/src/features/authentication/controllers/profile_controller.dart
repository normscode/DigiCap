import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:time_capsule/src/features/authentication/controllers/authentication_controller.dart';
import 'package:time_capsule/src/repository/user_repository.dart';

class ProfileController extends GetxController {
  final _authRepo = Get.put(AuthController());
  final _userRepo = Get.put(UserRepository());
  getUserData() {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }
}
