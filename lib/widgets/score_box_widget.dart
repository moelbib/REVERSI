import 'package:flutter/material.dart';
import 'package:reversi/assets/colors.dart';
import 'package:reversi/assets/text_themes.dart';
import 'package:reversi/models/game_variables.dart';
import 'package:reversi/others/game_board.dart';
import 'package:reversi/models/game_model.dart';

//show score boxes with active indications
Widget scoreBox(BoardPiece player, GameModel model, BuildContext context) {
  var label = roomId != ""
      ? joinedBy != "" && joinedBy == currentUser
          ? player == BoardPiece.cpu
              ? "You"
              : opponentPlayerData.playerName
          : player == BoardPiece.user
              ? 'You'
              : opponentPlayerData.playerName
      : player == BoardPiece.user
          ? 'You'
          : opponentPlayerData.playerName;
  var scoreText =
      player == BoardPiece.user ? '${model.blackScore}' : '${model.whiteScore}';

  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            color: const Color(0xffBFACE2).withOpacity(0.7),
            border: Border.all(
                color: model.player != player
                    ? Colors.transparent
                    : const Color.fromARGB(255, 45, 41, 85)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffBFACE2).withOpacity(0.7),
                blurRadius: 10, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: const Offset(
                  0.0, // Move to right 10  horizontally
                  0.0, // Move to bottom 10 Vertically
                ),
              )
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: player == BoardPiece.user
              ? Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: model.player != player
                                    ? Colors.transparent
                                    : currentColorPrimaryPlayer,
                                blurRadius: 25.0, // soften the shadow
                                spreadRadius: 0.5, //extend the shadow
                                offset: const Offset(
                                  0.0, // Move to right 10  horizontally
                                  0.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor:
                                currentColorPrimaryPlayer.withOpacity(0.5),
                            child: Text(
                              scoreText,
                              textAlign: TextAlign.center,
                              style: body1Grey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: body1GreyBlack,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: body1White,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: model.player != player
                                    ? Colors.transparent
                                    : currentColorPrimaryOpponent,
                                blurRadius: 25.0, // soften the shadow
                                spreadRadius: 0.5, //extend the shadow
                                offset: const Offset(
                                  0.0, // Move to right 10  horizontally
                                  0.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor:
                                currentColorPrimaryOpponent.withOpacity(0.5),
                            child: Text(
                              scoreText,
                              textAlign: TextAlign.center,
                              style: body1Grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    ),
  );
}
