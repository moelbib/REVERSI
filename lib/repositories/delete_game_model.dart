import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Get All users data from firebase
void deleteGameData() async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  try {
    await FirebaseFirestore.instance.collection("game").doc(uid).delete();
  } catch (ex) {
    log("Error deleteGameData $ex");
  }
}
