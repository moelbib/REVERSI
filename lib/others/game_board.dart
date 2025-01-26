/// BoardPiece: Enum for board values
/// getOpponent: check whether player is user or cpu
/// GameBoard: render board with filled values
/// getPieceCount: return player score
/// getMovesForPlayer: return legal moves for player
/// updateForMove: update board after move
/// traversePath: used for whether move is legal or not
/// _emptyBoard: add all values to board

enum BoardPiece {
  empty,
  user,
  cpu,
}

BoardPiece getOpponent(BoardPiece player) =>
    (player == BoardPiece.user) ? BoardPiece.cpu : BoardPiece.user;

class Position {
  final int x;
  final int y;

  const Position(this.x, this.y);
}

class GameBoard {
  static const height = 8;
  static const width = 8;
  final List<List<BoardPiece>> rows;
  final _availableMoveCache = <BoardPiece, List<Position>>{};
  GameBoard() : rows = _emptyBoard;

  GameBoard.fromRows(List<List<BoardPiece>> rows2) : rows = rows2;
  GameBoard.fromGameBoard(GameBoard other)
      : rows = List.generate(height, (i) => List.from(other.rows[i]));

  BoardPiece getPieceAtLocation(int x, int y) {
    assert(x >= 0 && x < width);
    assert(y >= 0 && y < height);
    return rows[y][x];
  }

  int getPieceCount(BoardPiece boardPiece) {
    return rows.fold(
      0,
      (s, e) => s + e.where((e) => e == boardPiece).length,
    );
  }

  List<Position> getMovesForPlayer(BoardPiece player) {
    if (player == BoardPiece.empty) {
      return [];
    }

    if (_availableMoveCache.containsKey(player)) {
      return _availableMoveCache[player]!;
    }

    final legalMoves = <Position>[];
    for (var x = 0; x < width; x++) {
      for (var y = 0; y < width; y++) {
        if (isLegalMove(x, y, player)) {
          legalMoves.add(Position(x, y));
        }
      }
    }

    _availableMoveCache[player] = legalMoves;
    return legalMoves;
  }

  GameBoard updateForMove(int x, int y, BoardPiece player) {
    assert(player != BoardPiece.empty);
    final newBoard = GameBoard.fromGameBoard(this);

    if (!isLegalMove(x, y, player)) {
      return newBoard;
    }

    newBoard.rows[y][x] = player;

    for (var dx = -1; dx <= 1; dx++) {
      for (var dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;
        newBoard._traversePath(x, y, dx, dy, player, true);
      }
    }

    //store newBoard Model

    return newBoard;
  }

  bool isLegalMove(int x, int y, BoardPiece player) {
    assert(player != BoardPiece.empty);
    assert(x >= 0 && x < width);
    assert(y >= 0 && y < height);
    if (rows[y][x] != BoardPiece.empty) return false;
    for (var dx = -1; dx <= 1; dx++) {
      for (var dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;
        if (_traversePath(x, y, dx, dy, player, false)) return true;
      }
    }

    return false;
  }

  bool _traversePath(
      int x, int y, int dx, int dy, BoardPiece player, bool flip) {
    var foundOpponent = false;
    var curX = x + dx;
    var curY = y + dy;

    while (curX >= 0 && curX < width && curY >= 0 && curY < height) {
      if (rows[curY][curX] == BoardPiece.empty) {
        return false;
      } else if (rows[curY][curX] == getOpponent(player)) {
        foundOpponent = true;
      } else if (foundOpponent) {
        if (flip) {
          while (curX != x || curY != y) {
            curX -= dx;
            curY -= dy;
            rows[curY][curX] = player;
          }
        }
        return true;
      } else {
        return false;
      }

      curX += dx;
      curY += dy;
    }

    return false;
  }
}

const _emptyBoard = [
  [
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
  ],
  [
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
  ],
  [
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
  ],
  [
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.user,
    BoardPiece.cpu,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
  ],
  [
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.cpu,
    BoardPiece.user,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
  ],
  [
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
  ],
  [
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
  ],
  [
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
    BoardPiece.empty,
  ],
];
