import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reversi/others/game_scorer.dart';

import 'game_board.dart';

class AIMoveSearchClass {
  AIMoveSearchClass(
      {required this.board, required this.player, required this.numPlies});

  final GameBoard board;
  final BoardPiece player;
  final int numPlies;
}

class ScoredMove {
  final int score;
  final Position move;

  const ScoredMove(this.score, this.move);
}

Position? findBestNextaIMove(AIMoveSearchClass args) {
  final bestMove =
      searchOnBoard(args.board, args.player, args.player, args.numPlies - 1);
  return bestMove?.move;
}

ScoredMove? searchOnBoard(
  GameBoard board,
  BoardPiece scoringPlayer,
  BoardPiece player,
  int pliesRemaining,
) {
  final availableMoves = board.getMovesForPlayer(player);

  if (availableMoves.isEmpty) {
    return null;
  }

  var score = (scoringPlayer == player)
      ? GameScorerForAI.minScore
      : GameScorerForAI.maxScore;
  ScoredMove? bestMove;

  for (var i = 0; i < availableMoves.length; i++) {
    final newBoard =
        board.updateForMove(availableMoves[i].x, availableMoves[i].y, player);
    if (pliesRemaining > 0 &&
        newBoard.getMovesForPlayer(getOpponent(player)).isNotEmpty) {
      // Opponent has next turn.
      score = searchOnBoard(
            newBoard,
            scoringPlayer,
            getOpponent(player),
            pliesRemaining - 1,
          )?.score ??
          0;
    } else if (pliesRemaining > 0 &&
        newBoard.getMovesForPlayer(player).isNotEmpty) {
      score = searchOnBoard(
            newBoard,
            scoringPlayer,
            player,
            pliesRemaining - 1,
          )?.score ??
          0;
    } else {
      score = GameScorerForAI(newBoard).getScore(scoringPlayer);
    }

    if (bestMove == null ||
        (score > bestMove.score && scoringPlayer == player) ||
        (score < bestMove.score && scoringPlayer != player)) {
      bestMove =
          ScoredMove(score, Position(availableMoves[i].x, availableMoves[i].y));
    }
  }

  return bestMove;
}

class MoveFinder {
  final GameBoard initialBoard;

  MoveFinder(this.initialBoard);
  Future<Position?> findNextMove(BoardPiece player, int numPlies) {
    return compute(
      findBestNextaIMove,
      AIMoveSearchClass(
        board: initialBoard,
        player: player,
        numPlies: numPlies,
      ),
    );
  }
}
