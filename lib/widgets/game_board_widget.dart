import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reversi/assets/box_color.dart';
import 'package:reversi/models/game_variables.dart';
import 'package:reversi/others/game_board.dart';
import 'package:reversi/models/game_model.dart';

//render gameboard, with action of to take move
List<Widget> gameBoard(BuildContext context, GameModel model,
    StreamController<GameModel> userMovesController) {
  final rows = <Widget>[];
  void attemptUserMove(GameModel model, int x, int y,
      StreamController<GameModel> userMovesController) {
    if (joinedBy != "" && joinedBy == currentUser
        ? model.player == BoardPiece.cpu &&
            model.board.isLegalMove(x, y, model.player)
        : model.player == BoardPiece.user &&
            model.board.isLegalMove(x, y, model.player)) {
      userMovesController.add(model.updateForMove(x, y, context));
    }
    // move decider for player 2
    else if (model.player == BoardPiece.cpu &&
        model.board.isLegalMove(x, y, model.player) &&
        opponentPlayerData.type == "Human") {
      userMovesController.add(model.updateForMove(x, y, context));
    }
  }

  for (var y = 0; y < GameBoard.height; y++) {
    final spots = <Widget>[];

    for (var x = 0; x < GameBoard.width; x++) {
      spots.add(AnimatedContainer(
        duration: const Duration(
          milliseconds: 500,
        ),
        margin: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          gradient: boardPieceColor[model.board.getPieceAtLocation(x, y)],
        ),
        child: SizedBox(
          width: 40.0,
          height: 40.0,
          child: GestureDetector(
            onTap: () {
              attemptUserMove(model, x, y, userMovesController);
            },
          ),
        ),
      ));
    }

    rows.add(Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: spots,
    ));
  }

  return rows;
}
