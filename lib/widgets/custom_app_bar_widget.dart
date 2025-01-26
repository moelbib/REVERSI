import 'package:flutter/material.dart';
import 'package:reversi/assets/text_themes.dart';
import 'package:reversi/screens/game_settings.dart';

//it show appbar of app it have settings icon which redirect user to setting page
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      color: const Color(0xffBFACE2).withOpacity(0.9),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffBFACE2).withOpacity(0.7),
              blurRadius: 20, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: const Offset(
                0.0, // Move to right 10  horizontally
                0.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/applogo.png",
              height: 40,
              width: 40,
            ),
            const Text(
              "Reversi Game",
              style: heading1White,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GameSettings()));
              },
              child: const Icon(
                Icons.settings,
                color: Color(0xe0ffffff),
                size: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
