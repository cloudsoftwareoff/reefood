import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reefood/screens/auth/main_auth.dart';
import 'package:reefood/screens/home/welcome_page.dart';

class Wrapper extends StatelessWidget {

   Wrapper({super.key});
bool isUserLoggedIn()  {
  
  User? user = FirebaseAuth.instance.currentUser;

  return user != null;
}


  @override
  Widget build(BuildContext context) {


    
    // return home or auth
    return  !isUserLoggedIn() ? AuthScreen() : HomePage();
  }
}