import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reversi/assets/colors.dart';
import 'package:reversi/firebase_options.dart';
import 'package:reversi/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}

//redirect user to splash screen, it have basic setup of what theme are we going to use
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'CaviarDreams',
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return bg2Color; // the color when checkbox is selected;
              }
              return secondryColor; //the color when checkbox is unselected;
            },
          ),
        ),
      ),
      onGenerateRoute: (settings) {
        return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SplashScreen(),
        );
      },
    );
  }
}
