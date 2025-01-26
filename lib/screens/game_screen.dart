// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, unused_local_variable

import 'dart:async';
import 'dart:developer';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:reversi/assets/colors.dart';
import 'package:reversi/assets/others.dart';
import 'package:reversi/dialogs/game_result_dialog.dart';
import 'package:reversi/models/game_variables.dart';
import 'package:reversi/others/game_board.dart';
import 'package:reversi/others/game_cpu_move.dart';
import 'package:reversi/dialogs/choose_player_dialog.dart';
import 'package:reversi/repositories/delete_game_model.dart';
import 'package:reversi/widgets/cpu_loader_widget.dart';
import 'package:reversi/widgets/custom_app_bar_widget.dart';
import 'package:reversi/widgets/game_board_widget.dart';
import 'package:reversi/widgets/score_box_widget.dart';

import '../models/game_model.dart';

class GameScreen extends StatefulWidget {
  final GameBoard? gameBoardReterive;
  final BoardPiece? boardPieceReterive;
  final String roomId;
  const GameScreen(
      {super.key,
      required this.gameBoardReterive,
      this.roomId = "",
      required this.boardPieceReterive});

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  final StreamController<GameModel> _userMovesController =
      StreamController<GameModel>();

  final StreamController<GameModel> _restartController =
      StreamController<GameModel>();
  Stream<GameModel>? _modelStream;
//Set GameScreenState
  GameScreenState() {
    _modelStream = StreamGroup.merge([
      _userMovesController.stream,
      _restartController.stream,
    ]).asyncExpand((model) async* {
      yield model;

      //Code  for AI
      if (opponentPlayerData.type == "CPU") {
        var newModel = model;

        while (newModel.player == BoardPiece.cpu) {
          //Finding best next move
          final finder = MoveFinder(newModel.board);
          final move = await finder.findNextMove(newModel.player, 5);

          //taking move
          if (move != null) {
            newModel = newModel.updateForMove(move.x, move.y, context);

            yield newModel;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _userMovesController.close();
    _restartController.close();
    super.dispose();
  }

  // Show prompt for selecting user
  displaychoosePlayerDialog() {
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      choosePlayerDialog(context);
    });
  }

  storeGameData() async {
    setState(() {
      roomId = widget.roomId;
    });

    if (roomId != "") {
      FirebaseFirestore.instance
          .collection("game")
          .doc(widget.roomId)
          .snapshots()
          .listen((event) {
        try {
          Map<String, dynamic> data = event.data()!;
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
          opponentPlayerData = OpponentPlayerData(
              playerName: playerName, id: playerId, type: type);
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
          GameModel tempModel =
              GameModel(board: gameBoard, player: boardPieceReterive);
          _userMovesController.add(tempModel);
        } catch (ex) {
          log("Error setGameData $ex");
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.gameBoardReterive == null && widget.roomId == "") {
      displaychoosePlayerDialog();
    }

    storeGameData();
  }

  // Show prompt after game finished
  void schedulerFunctionForResult(GameModel modal) {
    if (modal.gameIsOver) {
      Future.delayed(const Duration(seconds: 2)).whenComplete(() {
        deleteGameData();
        showResultDialog(context, modal);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameModel>(
      stream: _modelStream,
      builder: (context, snapshot) {
        return _buildWidgets(
          context,
          snapshot.hasData
              ? snapshot.data!
              : GameModel(
                  board: widget.gameBoardReterive == null
                      ? GameBoard()
                      : widget.gameBoardReterive!,
                  player: widget.boardPieceReterive == null
                      ? joinedBy != "" && joinedBy == currentUser
                          ? BoardPiece.cpu
                          : BoardPiece.user
                      : widget.boardPieceReterive!),
        );
      },
    );
  }

  Widget _buildWidgets(BuildContext context, GameModel model) {
    schedulerFunctionForResult(model);
    return Container(
      padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            bg1Color,
            bg2Color,
          ],
        ),
      ),
      child: SafeArea(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 100),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffBFACE2).withOpacity(0.5),
                      blurRadius: 2, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: const Offset(
                        0.0, // Move to right 10  horizontally
                        0.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    //Render gameBoard widget
                    ...gameBoard(context, model, _userMovesController)
                  ],
                ),
              ),
              const SizedBox(height: 30),
              CPULoader(
                color: model.player == BoardPiece.cpu
                    ? currentColorPrimaryOpponent
                    : currentColorPrimaryPlayer,
                height: thinkingSize,
                visible: true,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //render ScoreBox widgets
                  scoreBox(
                      joinedBy == ""
                          ? BoardPiece.user
                          : joinedBy != "" && joinedBy == currentUser
                              ? BoardPiece.cpu
                              : BoardPiece.user,
                      model,
                      context),
                  scoreBox(
                      joinedBy == ""
                          ? BoardPiece.cpu
                          : joinedBy != "" && joinedBy == currentUser
                              ? BoardPiece.user
                              : BoardPiece.cpu,
                      model,
                      context),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 5.3),
            ],
          ),
        ),
      ),
    );
  }
}
