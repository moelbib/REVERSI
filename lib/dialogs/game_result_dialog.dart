// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:reversi/assets/colors.dart';
import 'package:reversi/assets/text_themes.dart';
import 'package:reversi/models/game_model.dart';
import 'package:reversi/screens/game_screen.dart';
import 'package:reversi/screens/splash_screen.dart';

showResultDialog(BuildContext context, GameModel model) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Container(
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: bg1Color, width: 2))),
                child: Text(
                  model.blackScore > model.whiteScore
                      ? 'Gamer Over! Hurrah you win'
                      : model.whiteScore > model.blackScore
                          ? "Gamer Over! Oops you lost"
                          : "Game Over! Draw",
                  textAlign: TextAlign.center,
                  style: body1bg1Color,
                )),
            content: Text(
              textAlign: TextAlign.center,
              model.blackScore > model.whiteScore
                  ? 'Gamer Over! Hurrah you win, your score was ${model.blackScore} and your opponent score was ${model.whiteScore}. You won by ${model.blackScore - model.whiteScore} Points.'
                  : model.whiteScore > model.blackScore
                      ? "Gamer Over! Oops you lost, your score was ${model.blackScore} and your opponent score was ${model.whiteScore}. You lost by ${model.whiteScore - model.blackScore} Points."
                      : "Game Over! Draw, your score was ${model.blackScore} and your opponent score was ${model.whiteScore}.Game draw because both player points were equal and there is no legal move available on board.",
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 4, bottom: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GameScreen(
                                gameBoardReterive: null,
                                boardPieceReterive: null)),
                        (route) => false);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: bg1Color,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.gamepad,
                            color: secondryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "New Game",
                            style: body1Grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4, bottom: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()),
                        (route) => false);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: bg1Color,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.close,
                            color: secondryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Close Game",
                            style: body1Grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ));
}
