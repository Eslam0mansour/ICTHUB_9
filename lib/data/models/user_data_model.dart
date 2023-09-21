import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String email;
  final String pass;
  final String phone;
  final String name;
  final String image;
  final String uid;

  UserData({
    required this.email,
    required this.phone,
    required this.name,
    required this.image,
    required this.pass,
    required this.uid,
  });

  factory UserData.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return UserData(
      email: doc["userEmail"],
      pass: doc["userPass"],
      phone: doc["userPhone"],
      name: doc["userName"],
      image: doc["image"],
      uid: doc["uid"],
    );
  }
}
