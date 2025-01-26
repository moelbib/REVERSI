import 'package:flutter/material.dart';
import 'package:reversi/assets/colors.dart';
import 'package:reversi/models/game_variables.dart';
import 'package:reversi/repositories/store_game_model.dart';

import '../others/game_board.dart';

/// GameModel: used to manage board and player
/// based on update board updated
/// and based on player we render user move
/// in it we also find whether game is over(when no legal move)
class GameModel {
  late final GameBoard board;
  final BoardPiece player;

  GameModel({
    required this.board,
    this.player = BoardPiece.user,
  });

  int get blackScore => board.getPieceCount(BoardPiece.user);

  int get whiteScore => board.getPieceCount(BoardPiece.cpu);

  bool get gameIsOver => (board.getMovesForPlayer(player).isEmpty);

  String get gameResultString {
    if (blackScore > whiteScore) {
      return 'Black wins.';
    } else if (whiteScore > blackScore) {
      return 'White wins.';
    } else {
      return 'Tie.';
    }
  }

  GameModel updateForMove(int x, int y, BuildContext context) {
    if (!board.isLegalMove(x, y, player)) {
      throw Exception('Attempted to update board with an illegal move.');
    }

    final newBoard = board.updateForMove(x, y, player);
    BoardPiece nextPlayer;

    if (newBoard.getMovesForPlayer(getOpponent(player)).isNotEmpty) {
      nextPlayer = getOpponent(player);
    } else if (newBoard.getMovesForPlayer(player).isNotEmpty) {
      nextPlayer = player;
    } else {
      nextPlayer = BoardPiece.empty;
    }
    GameModel tempGameModel = GameModel(board: newBoard, player: nextPlayer);
    //store gameModel
    if (isAutoSaveChecked == true) {
      storeGameData(tempGameModel, opponentPlayerData.playerName,
          opponentPlayerData.id, opponentPlayerData.type, roomId);
    } else {
      if (roomId != "") {
        storeGameData(tempGameModel, opponentPlayerData.playerName,
            opponentPlayerData.id, opponentPlayerData.type, roomId);
      }
    }
    return tempGameModel;
  }
}
