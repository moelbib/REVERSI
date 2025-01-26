// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reversi/assets/colors.dart';
import 'package:reversi/assets/text_themes.dart';
import 'package:reversi/models/game_variables.dart';
import 'package:reversi/others/game_board.dart';
import 'package:reversi/repositories/check_create_room.dart';
import 'package:reversi/repositories/get_game_model.dart';
import 'package:reversi/repositories/get_user_data.dart';
import 'package:reversi/screens/game_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// It have lets play button which navigate user to game screen
class _SplashScreenState extends State<SplashScreen> {
  String roomId = "";
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      FirebaseAuth.instance.signInAnonymously();
    } else {
      setSettingsData();
      setGameData();
    }
  }

  setSettingsData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>>? userData = await getUserData();
      Map<String, dynamic> data = userData!.data()!;
      setState(() {
        pickerColorPrimaryOpponent = Color(int.parse(data["p1p"]));
        currentColorPrimaryOpponent = Color(int.parse(data["p1p"]));
        pickerColorSecondryOpponent = Color(int.parse(data["p1s"]));
        currentColorSecondryOpponent = Color(int.parse(data["p1s"]));
        pickerColorPrimaryPlayer = Color(int.parse(data["p2p"]));
        currentColorPrimaryPlayer = Color(int.parse(data["p2p"]));
        pickerColorSecondryPlayer = Color(int.parse(data["p2s"]));
        currentColorSecondryPlayer = Color(int.parse(data["p2s"]));
        isAutoSaveChecked = data["autoSave"] ?? false;
      });
    } catch (ex) {
      log("Error setColors $ex");
      setState(() {
        currentColorPrimaryOpponent = const Color(0xffe0e0e0);
        currentColorSecondryOpponent = const Color(0xff2B2B2B);
        currentColorPrimaryPlayer = const Color(0xff2B2B2B);
        currentColorSecondryPlayer = const Color(0xffe0e0e0);
        pickerColorPrimaryOpponent = const Color(0xffe0e0e0);
        pickerColorSecondryOpponent = const Color(0xff2B2B2B);
        pickerColorPrimaryPlayer = const Color(0xff2B2B2B);
        pickerColorSecondryPlayer = const Color(0xffe0e0e0);
        isAutoSaveChecked = false;
      });
    }
  }

  setGameData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>>? gameData = await getGameData();
      Map<String, dynamic> data = gameData!.data()!;
      List<dynamic> row1 = data["row1"];
      List<dynamic> row2 = data["row2"];
      List<dynamic> row3 = data["row3"];
      List<dynamic> row4 = data["row4"];
      List<dynamic> row5 = data["row5"];
      List<dynamic> row6 = data["row6"];
      List<dynamic> row7 = data["row7"];
      List<dynamic> row8 = data["row8"];
      String playerName = data["name"];
      String playerId = data["pid"];
      String player = data["player"];

      String type = data["type"];
      opponentPlayerData =
          OpponentPlayerData(playerName: playerName, id: playerId, type: type);
      List<List<BoardPiece>> allRows = [];
      List<BoardPiece> row1BoardPiece = [];
      for (var element in row1) {
        if (element == "BoardPiece.empty") {
          row1BoardPiece.add(BoardPiece.empty);
        } else if (element == "BoardPiece.user") {
          row1BoardPiece.add(BoardPiece.user);
        } else if (element == "BoardPiece.cpu") {
          row1BoardPiece.add(BoardPiece.cpu);
        }
      }
      allRows.add(row1BoardPiece);
      List<BoardPiece> row2BoardPiece = [];
      for (var element in row2) {
        if (element == "BoardPiece.empty") {
          row2BoardPiece.add(BoardPiece.empty);
        } else if (element == "BoardPiece.user") {
          row2BoardPiece.add(BoardPiece.user);
        } else if (element == "BoardPiece.cpu") {
          row2BoardPiece.add(BoardPiece.cpu);
        }
      }
      allRows.add(row2BoardPiece);

      List<BoardPiece> row3BoardPiece = [];
      for (var element in row3) {
        if (element == "BoardPiece.empty") {
          row3BoardPiece.add(BoardPiece.empty);
        } else if (element == "BoardPiece.user") {
          row3BoardPiece.add(BoardPiece.user);
        } else if (element == "BoardPiece.cpu") {
          row3BoardPiece.add(BoardPiece.cpu);
        }
      }
      allRows.add(row3BoardPiece);

      List<BoardPiece> row4BoardPiece = [];
      for (var element in row4) {
        if (element == "BoardPiece.empty") {
          row4BoardPiece.add(BoardPiece.empty);
        } else if (element == "BoardPiece.user") {
          row4BoardPiece.add(BoardPiece.user);
        } else if (element == "BoardPiece.cpu") {
          row4BoardPiece.add(BoardPiece.cpu);
        }
      }
      allRows.add(row4BoardPiece);

      List<BoardPiece> row5BoardPiece = [];
      for (var element in row5) {
        if (element == "BoardPiece.empty") {
          row5BoardPiece.add(BoardPiece.empty);
        } else if (element == "BoardPiece.user") {
          row5BoardPiece.add(BoardPiece.user);
        } else if (element == "BoardPiece.cpu") {
          row5BoardPiece.add(BoardPiece.cpu);
        }
      }
      allRows.add(row5BoardPiece);

      List<BoardPiece> row6BoardPiece = [];
      for (var element in row6) {
        if (element == "BoardPiece.empty") {
          row6BoardPiece.add(BoardPiece.empty);
        } else if (element == "BoardPiece.user") {
          row6BoardPiece.add(BoardPiece.user);
        } else if (element == "BoardPiece.cpu") {
          row6BoardPiece.add(BoardPiece.cpu);
        }
      }
      allRows.add(row6BoardPiece);

      List<BoardPiece> row7BoardPiece = [];
      for (var element in row7) {
        if (element == "BoardPiece.empty") {
          row7BoardPiece.add(BoardPiece.empty);
        } else if (element == "BoardPiece.user") {
          row7BoardPiece.add(BoardPiece.user);
        } else if (element == "BoardPiece.cpu") {
          row7BoardPiece.add(BoardPiece.cpu);
        }
      }
      allRows.add(row7BoardPiece);

      List<BoardPiece> row8BoardPiece = [];
      for (var element in row8) {
        if (element == "BoardPiece.empty") {
          row8BoardPiece.add(BoardPiece.empty);
        } else if (element == "BoardPiece.user") {
          row8BoardPiece.add(BoardPiece.user);
        } else if (element == "BoardPiece.cpu") {
          row8BoardPiece.add(BoardPiece.cpu);
        }
      }
      allRows.add(row8BoardPiece);
      // gameBoard.rows
      GameBoard gameBoard = GameBoard.fromRows(allRows);

      BoardPiece boardPieceReterive = BoardPiece.user;
      if (player == "BoardPiece.empty") {
        boardPieceReterive = BoardPiece.empty;
      } else if (player == "BoardPiece.user") {
        boardPieceReterive = BoardPiece.user;
      } else if (player == "BoardPiece.cpu") {
        boardPieceReterive = BoardPiece.cpu;
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => GameScreen(
                  gameBoardReterive: gameBoard,
                  boardPieceReterive: boardPieceReterive)));
    } catch (ex) {
      log("Error setGameData $ex");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xff645CBB),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffBFACE2).withOpacity(0.5),
                        blurRadius: 10, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: const Offset(
                          0.0, // Move to right 10  horizontally
                          0.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                    color: const Color(0xff2B2B2B).withOpacity(0.2)),
                child: Image.asset(
                  "assets/images/applogo.png",
                  width: MediaQuery.of(context).size.width - 100,
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            const Text(
              "Create/Join Room",
              style: heading2White,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    roomId = value;
                  });
                },
                style: body1bg1Color,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: secondryColor,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.numbers,
                    color: bg1Color,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            const Text(
              "Room Created by will have first turn.\nAfter Creating room wait for others to join.",
              style: body2Grey,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                if (roomId == "") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameScreen(
                              gameBoardReterive: null,
                              boardPieceReterive: null)));
                } else {
                  String result = await checkAndCreateRoom(roomId);
                  Fluttertoast.showToast(
                      msg: result, gravity: ToastGravity.BOTTOM);

                  if (result == "Room is Joined") {
                    log("joined By: $joinedBy,  created By: $createdBy, current User: $currentUser");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GameScreen(
                                gameBoardReterive: null,
                                roomId: roomId,
                                boardPieceReterive: null)));

                    opponentPlayerData = OpponentPlayerData(
                        playerName: "Remote", id: "Remote", type: "Remote");
                  }
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.height / 17,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffBFACE2).withOpacity(0.5),
                        blurRadius: 10, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: const Offset(
                          0.0, // Move to right 10  horizontally
                          0.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                    color: const Color(0xff2B2B2B).withOpacity(0.2)),
                child: const Center(
                  child: Text(
                    "Let's Play",
                    style: heading2White,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
