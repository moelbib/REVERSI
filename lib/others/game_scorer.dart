import 'package:reversi/others/game_board.dart';

class GameScorerForAI {
  static const _positionValues = [
    [10000, -1000, 100, 100, 100, 100, -1000, 10000],
    [-1000, -1000, 1, 1, 1, 1, -1000, -1000],
    [100, 1, 50, 50, 50, 50, 1, 100],
    [100, 1, 50, 1, 1, 50, 1, 100],
    [100, 1, 50, 1, 1, 50, 1, 100],
    [100, 1, 50, 50, 50, 50, 1, 100],
    [-1000, -1000, 1, 1, 1, 1, -1000, -1000],
    [10000, -1000, 100, 100, 100, 100, -1000, 10000],
  ];
  static const maxScore = 1000 * 1000 * 1000;
  static const minScore = -1 * maxScore;

  final GameBoard board;

  GameScorerForAI(this.board);

  int getScore(BoardPiece player) {
    assert(player != BoardPiece.empty);
    var opponent = getOpponent(player);
    var score = 0;

    if (board.getMovesForPlayer(BoardPiece.user).isEmpty &&
        board.getMovesForPlayer(BoardPiece.cpu).isEmpty) {
      // Game is over.
      var playerCount = board.getPieceCount(player);
      var opponentCount = board.getPieceCount(getOpponent(player));

      if (playerCount > opponentCount) {
        return maxScore;
      } else if (playerCount < opponentCount) {
        return minScore;
      } else {
        return 0;
      }
    }

    for (var y = 0; y < GameBoard.height; y++) {
      for (var x = 0; x < GameBoard.width; x++) {
        if (board.getPieceAtLocation(x, y) == player) {
          score += _positionValues[y][x];
        } else if (board.getPieceAtLocation(x, y) == opponent) {
          score -= _positionValues[y][x];
        }
      }
    }

    return score;
  }
}
