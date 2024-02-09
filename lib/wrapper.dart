import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reefood/screens/auth/choose_location.dart';
import 'package:reefood/screens/auth/main_auth.dart';
import 'package:reefood/screens/mainscreen/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:reefood/screens/home/home_screen.dart';
import 'package:reefood/screens/splash/welcome.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  Future<bool> hasSeenWelcomeScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasSeenWelcomeScreen') ?? false;
  }

  void markWelcomeScreenSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasSeenWelcomeScreen', true);
  }

  bool isUserLoggedIn() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: hasSeenWelcomeScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          bool hasSeenWelcomeScreen = snapshot.data ?? false;

          if (!hasSeenWelcomeScreen) {
            markWelcomeScreenSeen();
            // Show welcome screen
            return WelcomeScreen();
          } else {
            // Return home or auth
            return !isUserLoggedIn() ? AuthScreen() : MainScreenApp();
          }
        } else {
          // Show loading indicator or another placeholder widget
          return CircularProgressIndicator();
        }
      },
    );
  }
}
