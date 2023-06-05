import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_capsule/src/features/authentication/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/authentication_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthController authController = Get.put(AuthController());

  Future<void> _launchURL(String url) async {
    final Uri uri =
        Uri(scheme: "https", host: url, path: "/DigiCapTC/digicaptc.html");
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch URL";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 87, 156),
        body: Align(
          alignment: Alignment.center,
          child: Container(
            color: const Color.fromARGB(255, 16, 111, 158),
            width: 300,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "DigiCap",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  "assets/logo/logo2.png", // Replace with your logo image path
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
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
                          MaterialStateProperty.all<Size>(const Size(270, 50))),
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.orbitron(
                        fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
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
                          MaterialStateProperty.all<Size>(const Size(270, 50))),
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
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: const Text('Signup'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: authController.fullName,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Full Name is Required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: authController.email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is required.';
                        }

                        final emailRegex = RegExp(
                            r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Invalid email format.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: authController.password,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required.';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long.';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    TextFormField(
                      controller: authController.confirmPassword,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm Password is required.';
                        }
                        if (value != authController.password.text) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
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
                          child: GestureDetector(
                            onTap: () {
                              _launchURL("normanazares.github.io");
                            },
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: const TextSpan(
                                text: 'Accept ',
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Get.back();
                  },
                ),
                ElevatedButton(
                  child: const Text('Signup'),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (authController.isTermsAccepted()) {
                        await authController.signup();
                        final user = UserModel(
                          email: authController.email.text.trim(),
                          password: authController.password.text.trim(),
                          fullName: authController.fullName.text.trim(),
                          date: authController.getCurrentFormattedDate(),
                        );
                        authController.createUser(user);
                      } else {
                        Get.snackbar(
                          'Sign Up Failed',
                          'You must accept the Terms and Conditions.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

//Login Dialog Form
  void showLoginDialog(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: authController.email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required.';
                    }

                    final emailRegex = RegExp(
                        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Invalid email format.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: authController.password,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required.';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long.';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await authController.login();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
