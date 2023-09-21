import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icthubx/data/models/product_model.dart';
import 'package:icthubx/data/models/user_data_model.dart';

class DataSource {
  static Future<UserData?> getUserDataFromFireStore() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return UserData.fromDoc(userDoc);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static UserData? userData;
}
