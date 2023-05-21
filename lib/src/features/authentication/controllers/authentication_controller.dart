import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_capsule/src/features/authentication/screens/login_signup_screen.dart';
import 'package:time_capsule/src/repository/user_repository.dart';

import '../models/user_model.dart';
import '../screens/main_screen.dart';

class AuthController extends GetxController {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool acceptTerms = false.obs;
  static AuthController get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final userRepo = Get.put(UserRepository());

  // Method to toggle the acceptance status
  void toggleAcceptTerms() {
    acceptTerms.value = !acceptTerms.value;
  }

  // Method to check if the terms and conditions are accepted
  bool isTermsAccepted() {
    return acceptTerms.value;
  }

  //Signup Method
  Future<void> signup() async {
    if (!isTermsAccepted()) {
      // Display an error message if the terms and conditions are not accepted
      Get.snackbar(
        'Sign Up Failed',
        'You must accept the Terms and Conditions.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      // Signup successful, you can now handle the user creation
      User? user = userCredential.user;
      // Save additional user details if needed
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      String errorMessage = '';
      if (e.code == 'email-already-in-use') {
        errorMessage =
            'The email address is already in use. Please use a different email.';
      } else if (e.code == 'weak-password') {
        errorMessage =
            'The password is too weak. Please choose a stronger password.';
      } else {
        errorMessage = 'Sign up failed. Please try again.';
      }
      // Display the error message to the user
      Get.snackbar(
        'Sign Up Failed',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      // Handle signup failure
      print('Signup failed: $e');
      // Display an error message to the user
      Get.snackbar(
        'Sign Up Failed',
        'Sign up failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  //Login Method
  Future<void> login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      // Login successful, you can now handle the logged-in user
      User? user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'User not found. Please check your email and password.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password. Please try again.';
      } else {
        errorMessage = 'Login failed. Please try again.';
      }
      // Display the error message to the user
      Get.snackbar(
        'Login Failed',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      // Handle login failure
      print('Login failed: $e');
      Get.snackbar(
        'Login Failed',
        'Login failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Logout the current user
  void logout() async {
    try {
      await _auth.signOut();
      // Perform any additional cleanup or tasks after logout

      // Navigate to the login screen
      Get.offAll(() => LoginScreen());
      Get.snackbar('Logged Out', 'You have been successfully logged out.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    } catch (e) {
      print('Error logging out: $e');
      // Show an error message or handle the error as needed
    }
  }

  // Check authentication status and redirect accordingly
  void checkAuthStatus() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is authenticated, navigate to home screen
        Get.offAll(() => MainScreen());
      } else {
        // User is not authenticated, navigate to login screen
        Get.offAll(() => LoginScreen());
      }
    });
  }

  //Create User and Store to Firestore
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }
}
