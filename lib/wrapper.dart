import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:reefood/screens/mainscreen/mainscreen.dart';
import 'package:reefood/screens/splash/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          // Ensure the user is logged in
          if (user != null) {
            // Return home
            return MainScreenApp();
          } else {
            // Show auth or login screen
            return OnBoarding1();
          }
        } else {
          // Show loading indicator or another placeholder widget
          return CircularProgressIndicator();
        }
      },
    );
  }
}
