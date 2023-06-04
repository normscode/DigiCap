import 'package:cloud_firestore/cloud_firestore.dart';

class MemoryModel {
  final String? id;
  final String title;
  final String description;
  final Timestamp? date;
  final String? photoURL;
  final String? voiceTagURL;

  const MemoryModel({
    this.id,
    required this.title,
    required this.description,
    this.date,
    this.photoURL,
    this.voiceTagURL,
  });

  toJson() {
    return {
      "Title": title,
      "Description": description,
      "Date": date,
      "PhotoURL": photoURL,
      "voiceTagURL": voiceTagURL,
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
      voiceTagURL: data["VoiceTagURL"],
    );
  }
}
