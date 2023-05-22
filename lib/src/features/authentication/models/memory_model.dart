import 'package:cloud_firestore/cloud_firestore.dart';

class MemoryModel {
  final String? id;
  final String title;
  final String description;
  final String? date;
  final String? photoURL;

  const MemoryModel({
    this.id,
    required this.title,
    required this.description,
    this.date,
    this.photoURL,
  });

  toJson() {
    return {
      "Title": title,
      "Description": description,
      "Date": date,
      "PhotoURL": photoURL,
    };
  }

  factory MemoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MemoryModel(
      id: document.id,
      title: data["Title"],
      description: data["Description"],
      date: data["Date"],
      photoURL: data["PhotoURL"],
    );
  }
}
