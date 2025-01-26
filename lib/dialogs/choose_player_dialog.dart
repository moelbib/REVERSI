import 'package:flutter/material.dart';
import 'package:reversi/assets/colors.dart';
import 'package:reversi/assets/text_themes.dart';
import 'package:reversi/models/game_variables.dart';

choosePlayerDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: bg1Color, width: 2))),
                child: const Text(
                  'Choose Player',
                  textAlign: TextAlign.center,
                  style: body1bg1Color,
                )),
            content: const Text(
                textAlign: TextAlign.center,
                'Choose your oponent, with whom you want to play game.'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 4, bottom: 8),
                child: InkWell(
                  onTap: () {
                    opponentPlayerData = OpponentPlayerData(
                        playerName: "CPU", id: "CPU", type: "CPU");
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.2,
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
                            Icons.view_compact_alt_rounded,
                            color: secondryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "CPU",
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
                    opponentPlayerData = OpponentPlayerData(
                        playerName: "Human", id: "Human", type: "Human");
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.2,
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
                            Icons.person,
                            color: secondryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Human",
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
