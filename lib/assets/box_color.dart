import 'package:flutter/material.dart';
import 'package:reversi/assets/colors.dart';
import 'package:reversi/others/game_board.dart';

//All Gradient colors for empty, cpu, player pieces
Map<BoardPiece, LinearGradient> boardPieceColor = {
  BoardPiece.user: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      currentColorPrimaryPlayer,
      currentColorSecondryPlayer,
      currentColorPrimaryPlayer,
      currentColorPrimaryPlayer,
      currentColorPrimaryPlayer,
      currentColorPrimaryPlayer,
      currentColorPrimaryPlayer,
      currentColorSecondryPlayer,
      currentColorPrimaryPlayer,
    ],
  ),
  BoardPiece.cpu: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      currentColorPrimaryOpponent,
      currentColorSecondryOpponent,
      currentColorPrimaryOpponent,
      currentColorPrimaryOpponent,
      currentColorPrimaryOpponent,
      currentColorPrimaryOpponent,
      currentColorPrimaryOpponent,
      currentColorSecondryOpponent,
      currentColorPrimaryOpponent,
    ],
  ),
  BoardPiece.empty: const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x60ffffff),
      Color(0x40ffffff),
      Color(0x60ffffff),
      Color(0x60ffffff),
      Color(0x60ffffff),
      Color(0x60ffffff),
      Color(0x60ffffff),
      Color(0x40ffffff),
      Color(0x60ffffff),
    ],
  ),
};
