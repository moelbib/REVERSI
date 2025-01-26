import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:reversi/assets/colors.dart';
import 'package:reversi/assets/text_themes.dart';
import 'package:reversi/widgets/custom_app_bar_widget.dart';

import '../repositories/store_user_data.dart';

class GameSettings extends StatefulWidget {
  const GameSettings({super.key});

  @override
  State<GameSettings> createState() => _GameSettingsState();
}

//Game Settings Screen
class _GameSettingsState extends State<GameSettings> {
  //change colors and store colors
  setAllColors() {
    setState(() {
      currentColorPrimaryOpponent = pickerColorPrimaryOpponent;
      currentColorSecondryOpponent = pickerColorSecondryOpponent;
      currentColorPrimaryPlayer = pickerColorPrimaryPlayer;
      currentColorSecondryPlayer = pickerColorSecondryPlayer;
    });
    storeUserData(
        currentColorPrimaryOpponent.value.toString(),
        currentColorSecondryOpponent.value.toString(),
        currentColorPrimaryPlayer.value.toString(),
        currentColorSecondryPlayer.value.toString(),
        isAutoSaveChecked);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Values will take effect after you take move"),
      duration: Duration(milliseconds: 1000),
    ));
  }

// ValueChanged<Color> callback
  void changeColorOponenetPrimary(Color color) {
    setState(() => pickerColorPrimaryOpponent = color);
  }

// ValueChanged<Color> callback
  void changeColorOponenetSecondry(Color color) {
    setState(() => pickerColorSecondryOpponent = color);
  }

  // ValueChanged<Color> callback
  void changeColorPlayerPrimary(Color color) {
    log("change color");
    setState(() => pickerColorPrimaryPlayer = color);
  }

// ValueChanged<Color> callback
  void changeColorPlayerSecondry(Color color) {
    log("change color 2");

    setState(() => pickerColorSecondryPlayer = color);
  }
// raise the [showDialog] widget

//This function show dialog in which user can update player color codes
  getFunction(String val) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: val == "p1p"
                  ? pickerColorPrimaryOpponent
                  : val == "p1s"
                      ? pickerColorSecondryOpponent
                      : val == "p2p"
                          ? pickerColorPrimaryPlayer
                          : pickerColorSecondryPlayer,
              onColorChanged: val == "p1p"
                  ? changeColorOponenetPrimary
                  : val == "p1s"
                      ? changeColorOponenetSecondry
                      : val == "p2p"
                          ? changeColorPlayerPrimary
                          : changeColorPlayerSecondry,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                setAllColors();
                // setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } // raise the [showDialog] widget

//This function show dialog in which app instructions shown
  getInstructions() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Instructions'),
          content: SingleChildScrollView(
            child: Column(
              children: const [
                Text(
                    "1. Player's toss a coin to decide who will play first. Each turn, the player places one piece on the board with their colour facing up."),
                SizedBox(height: 15),
                Text(
                    "2. For the first four moves, the players must play to one of the four squares in the middle of the board and no pieces are captured or reversed."),
                SizedBox(height: 15),
                Text(
                    "3. Each piece played must be laid adjacent to an opponent's piece so that the opponent's piece or a row of opponent's pieces is flanked by the new piece and another piece of the player's colour. All of the opponent's pieces between these two pieces are 'captured' and turned over to match the player's colour."),
                SizedBox(height: 15),
                Text(
                    "4. It can happen that a piece is played so that pieces or rows of pieces in more than one direction are trapped between the new piece played and other pieces of the same colour. In this case, all the pieces in all viable directions are turned over."),
                SizedBox(height: 15),
                Text(
                    "5. The game is over when neither player has a legal move (i.e. a move that captures at least one opposing piece) or when the board is full.")
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } // raise the [showDialog] widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff645CBB),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            const CustomAppBar(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Game Options",
              style: heading2White,
              textAlign: TextAlign.center,
            ),

            /****** Game General Setting ******/
            const SettingHeader(
              title: "Game Settings",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Auto Save",
                  style: body1Grey,
                ),
                Checkbox(
                  value: isAutoSaveChecked,
                  onChanged: (value) {
                    setState(() {
                      isAutoSaveChecked = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Game Instructions",
                  style: body1Grey,
                ),
                InkWell(
                  onTap: () {
                    getInstructions();
                  },
                  child: const Text(
                    "Open",
                    style: body1Grey,
                  ),
                ),
              ],
            ),
            /****** Oponenet Setting ******/
            const SettingHeader(
              title: "Player 2 Settings",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Main Color",
                  style: body1Grey,
                ),
                InkWell(
                  onTap: () {
                    getFunction("p1p");
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        color: currentColorPrimaryOpponent,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "#${currentColorPrimaryOpponent.value}",
                        style: body1Grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Secondry Color",
                  style: body1Grey,
                ),
                InkWell(
                  onTap: () {
                    getFunction("p2s");
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        color: currentColorSecondryOpponent,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "#${currentColorSecondryOpponent.value}",
                        style: body1Grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /****** Player Setting ******/
            const SettingHeader(
              title: "Player 1 Settings",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Main Color",
                  style: body1Grey,
                ),
                InkWell(
                  onTap: () {
                    getFunction("p2p");
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        color: currentColorPrimaryPlayer,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "#${currentColorPrimaryPlayer.value}",
                        style: body1Grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Secondry Color",
                  style: body1Grey,
                ),
                InkWell(
                  onTap: () {
                    getFunction("p2s");
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        color: currentColorSecondryPlayer,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "#${currentColorSecondryPlayer.value}",
                        style: body1Grey,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

class SettingHeader extends StatelessWidget {
  final String title;
  const SettingHeader({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white))),
          // ignore: prefer_const_constructors
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              title,
              style: heading3White,
              textAlign: TextAlign.left,
            ),
          )),
    );
  }
}
