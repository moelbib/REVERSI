import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reversi/models/game_model.dart';
import 'package:reversi/others/game_board.dart';

// Store Game data on firebase
Future<bool> storeGameData(GameModel gameModel, String playerName,
    String playerId, String playerType, String roomId) async {
  bool flag = false;
  String uid = roomId == "" ? FirebaseAuth.instance.currentUser!.uid : roomId;
  String player = gameModel.player.toString();
  GameBoard board = gameModel.board;
  List<List<BoardPiece>> rows = board.rows;
  List<String> row1 = [];
  List<String> row2 = [];
  List<String> row3 = [];
  List<String> row4 = [];
  List<String> row5 = [];
  List<String> row6 = [];
  List<String> row7 = [];
  List<String> row8 = [];
  int index = 1;
  for (var element in rows) {
    for (var element2 in element) {
      if (index == 1) {
        row1.add(element2.toString());
      } else if (index == 2) {
        row2.add(element2.toString());
      } else if (index == 3) {
        row3.add(element2.toString());
      } else if (index == 4) {
        row4.add(element2.toString());
      } else if (index == 5) {
        row5.add(element2.toString());
      } else if (index == 6) {
        row6.add(element2.toString());
      } else if (index == 7) {
        row7.add(element2.toString());
      } else if (index == 8) {
        row8.add(element2.toString());
      }
    }
    index++;
  }
  try {
    FirebaseFirestore.instance.collection("game").doc(uid).set({
      "player": player,
      "row1": row1,
      "row2": row2,
      "row3": row3,
      "row4": row4,
      "row5": row5,
      "row6": row6,
      "row7": row7,
      "row8": row8,
      "name": playerName,
      "pid": playerId,
      "type": playerType,
    });
    flag = true;
  } catch (ex) {
    log("Error storeGameData $ex");
    flag = false;
  }
  return flag;
}
