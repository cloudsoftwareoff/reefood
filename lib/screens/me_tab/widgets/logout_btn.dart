import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/wrapper.dart';

class Logoutbtn extends StatelessWidget {
  const Logoutbtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      child: 
      ElevatedButton(
        onPressed: () async {
          // Log out the user
          await FirebaseAuth.instance.signOut();

          // Pop out all widgets
          Navigator.of(context).popUntil((route) => route.isFirst);

          // Launch AuthScreenWidget
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Wrapper()),
          );
        },
        child: Text('Log Out',
        style: TextStyle(
          color: Colors.redAccent
        ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(130, 50), // Replaces width and height
          padding: EdgeInsets.zero, // Replaces padding,
          primary: Colors.white, // Replaces color
          textStyle: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: Color(0xFF606A85),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          ), 
          elevation: 0,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color:Colors.redAccent,
            width: 2,
          ), 
          ), 
        ),
)

    );
  }
}