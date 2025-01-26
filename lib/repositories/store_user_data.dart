import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Store user data on firebase
Future<bool> storeUserData(
    String p1p, String p1s, String p2p, String p2s, bool autoSave) async {
  bool flag = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  try {
    FirebaseFirestore.instance.collection("users_data").doc(uid).set({
      "p1p": p1p,
      "p1s": p1s,
      "p2p": p2p,
      "p2s": p2s,
      "autoSave": autoSave,
    });
    flag = true;
  } catch (ex) {
    log("Error storeCustomColors $ex");
    flag = false;
  }
  return flag;
}
