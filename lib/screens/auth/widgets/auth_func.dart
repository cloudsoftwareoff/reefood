import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reefood/components/auth_comp.dart';
import 'package:reefood/model/user_profile.dart';
import 'package:reefood/screens/auth/login_screen.dart';
import 'package:reefood/services/api/ip_lookup.dart';
import 'package:reefood/services/users/userAuth.dart';
import 'package:reefood/services/users/xUser.dart';

Future<void> signIn(
    {required String email,
    required String password,
    required BuildContext context}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  try {
    RegistrationResult? result =
        await AuthService().signInWithEmailAndPassword(email, password);

    if (result != null && result.user != null) {
      //Login success
      if (context.mounted) {
        Navigator.popAndPushNamed(context, '/home');
      }
    } else if (result!.error != null) {
      //Registration failed
      if (context.mounted) {
        showAlert(
            context: context,
            title: 'Login Failed',
            desc: '${result.error}',
            onPressed: () {
              Navigator.pop(context);
            }).show();
      }
    }
  } catch (e) {
    if (context.mounted) {
      signUpAlert(
        context: context,
        onPressed: () {
          Navigator.popAndPushNamed(context, LoginScreen.id);
        },
        title: 'Login Failed',
        desc: 'Something went wrong',
        btnText: 'Try Now',
      ).show();
    }
  }
}

Future<void> createAccount(
    {required String email,
    required String name,
    required String password,
    required BuildContext context}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  try {
    RegistrationResult? result =
        await AuthService().registerWithEmailAndPassword(email, password);
    if (result != null && result.user != null) {
      // Registration successful
      final String userLocation = await getUserLocation();

      UserProfile userProfile = UserProfile(
          uid: FirebaseAuth.instance.currentUser!.uid,
          fullname: name,
          profilePictureUrl: "default",
          ipLocation: userLocation,
          lastActive: Timestamp.now());

      await UserProfileProvider().addUserToFirestore(userProfile);

      if (context.mounted) {
        Navigator.popAndPushNamed(context, '/home');
      }
    } else if (result!.error != null) {
      // Registration failed
      if (context.mounted) {
        showAlert(
          context: context,
          title: 'Signup Failed',
          desc: '${result.error}',
          onPressed: () {
            Navigator.pop(context);
          },
        ).show();
      }
    }
  } catch (e) {
    if (context.mounted) {
      signUpAlert(
        context: context,
        onPressed: () {
          SystemNavigator.pop();
        },
        title: 'SOMETHING WRONG',
        desc: 'Close the app and try again',
        btnText: 'Close Now',
      );
    }
  }
}
