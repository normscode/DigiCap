import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../controllers/authentication_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../models/user_model.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;

                  final email = TextEditingController(text: userData.email);
                  final password =
                      TextEditingController(text: userData.password);
                  final fullName =
                      TextEditingController(text: userData.fullName);

                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Image(
                                    image: AssetImage(
                                        'assets/images/profile-empty.png'))),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.orange,
                                ),
                                child: const Icon(
                                  LineAwesomeIcons.camera,
                                  size: 20.0,
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullName,
                              decoration: const InputDecoration(
                                  label: Text('Full Name'),
                                  prefixIcon: Icon(LineAwesomeIcons.user)),
                            ),
                            const SizedBox(height: 30 - 20),
                            TextFormField(
                              controller: email,
                              decoration: const InputDecoration(
                                  label: Text('E-mail'),
                                  prefixIcon:
                                      Icon(LineAwesomeIcons.envelope_1)),
                            ),
                            const SizedBox(height: 30 - 20),
                            TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  label: Text("Password"),
                                  prefixIcon:
                                      Icon(LineAwesomeIcons.fingerprint)),
                            ),
                            const SizedBox(height: 30 - 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final user = UserModel(
                                    fullName: fullName.text.trim(),
                                    email: email.text.trim(),
                                    password: password.text.trim(),
                                    date: userData.date,
                                  );
                                  await controller.updateRecord(user);
                                },
                                // Get.to(() => const UpdateProfileScreen()),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child: const Text('Edit Profile',
                                    style: TextStyle(color: Color(0xFF000000))),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(height: 16.0),
                            Text(
                              'Joined: ${controller.formatTimeStamp(userData.date!)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
