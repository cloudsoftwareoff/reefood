import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reefood/model/user_profile.dart';
import 'package:reefood/screens/home/home_screen.dart';
import 'package:reefood/services/api/ip_lookup.dart';
import 'package:reefood/services/users/userdb.dart';
import 'package:reefood/services/users/userAuth.dart';


class SocialLogin extends StatelessWidget {
  const SocialLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 24),
              child: Center(
                // Assuming you want to center the text
                child: Text(
                  'Or sign up with',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )),
        Align(
          alignment: AlignmentDirectional(0, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
            child: Wrap(
              spacing: 16,
              runSpacing: 0,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.center,
              verticalDirection: VerticalDirection.down,
              clipBehavior: Clip.none,
              children: [
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          UserCredential me =
                              await AuthService().signInWithGoogle();
                          final String userLocation = await getUserLocation();


                          UserProfile userProfile = UserProfile(
                            uid: FirebaseAuth.instance.currentUser!.uid,
                             fullname:  me.user!.displayName ?? "reefood user",
                              profilePictureUrl:  me.user!.photoURL ?? "default",
                              
                                ipLocation: userLocation, 
                                lastActive: Timestamp.now(), 
                              
                                  );
                       

                          await UserProfileProvider()
                              .addUserToFirestore(userProfile);
                          // Pop out all widgets
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);

                        
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                        } catch (error) {
                          print(error);
                          // Handle errors or failed sign-in
                        }
                      },
                      icon: FaIcon(FontAwesomeIcons.google, size: 20),
                      label:const Text(
                        'Continue with Google',
                        style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(
                                0xFF101213) // Make sure the text color is visible
                            ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF101213),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Color(0xFFE0E3E7), width: 2),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF101213),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Color(0xFFE0E3E7), width: 2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Button takes the minimum needed space
                        children: [
                          FaIcon(FontAwesomeIcons.apple, size: 20),
                          SizedBox(width: 8), // Adjust spacing as needed
                          Text(
                            'Continue with Apple',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
