import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_capsule/src/features/authentication/models/user_model.dart';
import '../controllers/authentication_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 1, 87, 156),
        body: Align(
          alignment: Alignment.center,
          child: Container(
            color: Color.fromARGB(255, 16, 111, 158),
            width: 300,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "DigiCap",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                Image.asset(
                  "assets/logo/logo2.png", // Replace with your logo image path
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showLoginDialog(context);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0))),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      fixedSize:
                          MaterialStateProperty.all<Size>(Size(270, 50))),
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.orbitron(
                        fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    //showSignupDialog(context);
                    showSignupDialog(context);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0))),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      fixedSize:
                          MaterialStateProperty.all<Size>(Size(270, 50))),
                  child: Text(
                    'Sign Up Today',
                    style: GoogleFonts.orbitron(
                        fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  //Signup Dialog Form
  void showSignupDialog(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Signup'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: authController.fullName,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Full name is required.';
                    }
                    return null;
                  },
                ),
                TextField(
                  controller: authController.email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: authController.password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                TextField(
                  controller: authController.confirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                ),
                Row(
                  children: [
                    Obx(() => Checkbox(
                          value: authController.acceptTerms.value,
                          onChanged: (value) {
                            authController.toggleAcceptTerms();
                          },
                        )),
                    Flexible(
                        child: Text(
                      'Accept Terms and Conditions',
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: Text('Signup'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await authController.signup();
                  final user = UserModel(
                    email: authController.email.text.trim(),
                    password: authController.password.text.trim(),
                    fullName: authController.fullName.text.trim(),
                  );
                  authController.createUser(user);
                }
              },
            ),
          ],
        );
      },
    );
  }

//Login Dialog Form
  void showLoginDialog(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: authController.email,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: authController.password,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () async {
                await authController.login();
              },
            ),
          ],
        );
      },
    );
  }
}
