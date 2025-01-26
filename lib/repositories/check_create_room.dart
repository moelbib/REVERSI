import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reversi/models/game_variables.dart';

// Store user data on firebase
Future<String> checkAndCreateRoom(String roomId) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  currentUser = uid;
  DocumentSnapshot<Map<String, dynamic>> roomData =
      await FirebaseFirestore.instance.collection("room").doc(roomId).get();

  if (roomData.data() == null) {
    FirebaseFirestore.instance
        .collection("room")
        .doc(roomId)
        .set({"created_by": uid});
    createdBy = uid;
    return "Room is Created, Wait for other to join, when other join click on button again.";
  } else {
    var data = roomData.data()!;
    var joinedByLocal = data['joined_by'];
    if (joinedByLocal == null) {
      if (data['created_by'] != uid) {
        FirebaseFirestore.instance
            .collection("room")
            .doc(roomId)
            .set({"joined_by": uid}, SetOptions(merge: true));
        joinedBy = uid;
        createdBy = data['created_by'];
        return "Room is Joined";
      }
      if (joinedByLocal != null) {
        joinedBy = data['joined_by'];
        createdBy = data['created_by'];
        return "Room is Joined";
      } else {
        return "Wait for others to join";
      }
    } else {
      if (data['created_by'] == uid || data['joined_by'] == uid) {
        joinedBy = data['joined_by'];
        createdBy = data['created_by'];
        return "Room is Joined";
      }
      return "You can not join this room.";
    }
  }
}
