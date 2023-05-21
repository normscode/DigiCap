import 'package:flutter/material.dart';
import 'package:time_capsule/src/features/authentication/screens/login_signup_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/features/authentication/controllers/authentication_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    // Call checkAuthStatus to handle initial authentication status
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.checkAuthStatus();
    });
    return GetMaterialApp(
        title: 'DigiCap',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginScreen());
  }
}
