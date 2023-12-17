// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// //import 'package:loading_overlay/loading_overlay.dart';
// import 'package:reefood/components/auth_comp.dart';

// import 'package:reefood/constants.dart';
// import 'package:reefood/model/user_profile.dart';
// import 'package:reefood/screens/auth/login_screen.dart';
// import 'package:reefood/screens/auth/main_auth.dart';
// import 'package:reefood/services/api/ip_lookup.dart';
// import 'package:reefood/services/users/XUser.dart';
// import 'package:reefood/services/users/userAuth.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//   static String id = 'signup_screen';

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _auth = FirebaseAuth.instance;
//   late String _email;
//   late String _name;
//   late String _pass;
//   bool _saving = false;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.popAndPushNamed(context, AuthScreen.id);
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body:  SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const TopScreenImage(screenImageName: 'logo.png'),
//                   Expanded(
//                     flex: 2,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 15,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           const ScreenTitle(title: 'Sign Up'),
//                           CustomTextField(
//                             textField: TextField(
//                               onChanged: (value) {
//                                 _email = value;
//                               },
//                               style: const TextStyle(
//                                 fontSize: 20,
//                               ),
//                               decoration: kTextInputDecoration.copyWith(
//                                 hintText: 'Email',
//                               ),
//                             ),
//                           ),
//                           CustomTextField(
//                             textField: TextField(
                           
//                               onChanged: (value) {
//                                 _name = value;
//                               },
//                               style: const TextStyle(
//                                 fontSize: 20,
//                               ),
//                               decoration: kTextInputDecoration.copyWith(
//                                 hintText: 'Name',
//                               ),
//                             ),
//                           ),
//                           CustomTextField(
//                             textField: TextField(
//                               obscureText: true,
//                               onChanged: (value) {
//                                 _pass = value;
//                               },
//                               style: const TextStyle(
//                                 fontSize: 20,
//                               ),
//                               decoration: kTextInputDecoration.copyWith(
//                                 hintText: 'Password',
//                               ),
//                             ),
//                           ),
//                           CustomBottomScreen(
//                             textButton: 'Sign Up',
//                             heroTag: 'signup_btn',
//                             question: 'Have an account?',
//                             buttonPressed: () async {
//                               FocusManager.instance.primaryFocus?.unfocus();
//                               setState(() {
//                                 _saving = true;
//                               });
                            
//               try {
//                   RegistrationResult? result = await AuthService().registerWithEmailAndPassword(_email, _pass);
//                   if (result !=null && result.user != null) {

//                   // Registration successful
//                   if (context.mounted) {
    
//                       final String userlocation = await getUserLocation();

//                       UserProfile newUserProfile = UserProfile(
//                       uid: FirebaseAuth.instance.currentUser!.uid, 
//                         fullname: _name,
//                         pfp: 'default',
//                         bio: 'Hello, I am a new user!',
//                         phone: '',
//                         last_active: Timestamp.now(),
                        
//                         location: userlocation,
//                             );

//                     await UserProfileProvider().addUserToFirestore(newUserProfile);
//                       if(context.mounted){
//                           Navigator.popAndPushNamed(
//                                               context, '/home');
                              
//                           }}
                  
                  
                  
//                   } else if (result!.error != null) {
//                 // Registration failed
//                   if(context.mounted){
//                   showAlert(
//                                     context: context,
//                                     title: 'Signup Failed',
//                                     desc:
//                                         '${result.error}',
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     }).show();
//       }       }
  
                                  
//                                 } catch (e) {
//                     if (context.mounted){              
//                                   signUpAlert(
//                                       context: context,
//                                       onPressed: () {
//                                         SystemNavigator.pop();
//                                       },
//                                       title: 'SOMETHING WRONG',
//                                       desc: 'Close the app and try again',
//                                       btnText: 'Close Now');
//                                 }
//                                 }
//                             },
//                             questionPressed: () async {
//                               Navigator.pushNamed(context, LoginScreen.id);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:reefood/components/auth_comp.dart';
import 'package:reefood/constants.dart';
import 'package:reefood/model/user_profile.dart';
import 'package:reefood/screens/auth/login_screen.dart';
import 'package:reefood/screens/auth/main_auth.dart';
import 'package:reefood/services/api/ip_lookup.dart';
import 'package:reefood/services/users/XUser.dart';
import 'package:reefood/services/users/userAuth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String id = 'signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _name;
  late String _pass;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, AuthScreen.id);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LoadingOverlay(
            isLoading: _saving,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TopScreenImage(screenImageName: 'logo.png'),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ScreenTitle(title: 'Sign Up'),
                          CustomTextField(
                            textField: TextField(
                              onChanged: (value) {
                                _email = value;
                              },
                              style: const TextStyle(fontSize: 20),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Email',
                              ),
                            ),
                          ),
                          CustomTextField(
                            textField: TextField(
                              onChanged: (value) {
                                _name = value;
                              },
                              style: const TextStyle(fontSize: 20),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Name',
                              ),
                            ),
                          ),
                          CustomTextField(
                            textField: TextField(
                              obscureText: true,
                              onChanged: (value) {
                                _pass = value;
                              },
                              style: const TextStyle(fontSize: 20),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Password',
                              ),
                            ),
                          ),
                          CustomBottomScreen(
                            textButton: 'Sign Up',
                            heroTag: 'signup_btn',
                            question: 'Have an account?',
                            buttonPressed: _handleSignUp,
                            questionPressed: () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUp() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _saving = true;
    });

    try {
      RegistrationResult? result = await AuthService().registerWithEmailAndPassword(_email, _pass);
      if (result != null && result.user != null) {
        // Registration successful
        final String userLocation = await getUserLocation();

        UserProfile newUserProfile = UserProfile(
          uid: FirebaseAuth.instance.currentUser!.uid,
          fullname: _name,
          pfp: 'default',
          bio: 'Hello, I am a new user!',
          phone: '',
          last_active: Timestamp.now(),
          location: userLocation,
        );

        await UserProfileProvider().addUserToFirestore(newUserProfile);
        setState(() {
          _saving=false;
        });
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
}
