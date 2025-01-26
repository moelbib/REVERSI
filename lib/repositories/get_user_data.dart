import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Get All users data from firebase
Future<DocumentSnapshot<Map<String, dynamic>>?> getUserData() async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  try {
    DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection("users_data")
        .doc(uid)
        .get();
    return userData;
  } catch (ex) {
    log("Error getCustomColors $ex");
    return null;
  }
}
