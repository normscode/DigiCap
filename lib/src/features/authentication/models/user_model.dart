import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String password;
  final Timestamp? date;

  const UserModel({
    this.id,
    this.date,
    required this.email,
    required this.password,
    required this.fullName,
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Password": password,
      "Date": date,
    };
  }

  //Step 1 - Map User fetched from firebase to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data["Email"],
      password: data["Password"],
      fullName: data["FullName"],
      date: data["Date"],
    );
  }
}
