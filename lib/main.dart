import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_capsule/src/features/authentication/screens/login_signup_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_capsule/src/services/permissions.dart';
import 'src/features/authentication/controllers/authentication_controller.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  await Permission.notification.request();
  await Permission.microphone.request();
  NotificationService.initializeNotification();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId('96f3b655-5501-44d0-91cd-30731c7e3191');
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted Permission: $accepted");
  });
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
