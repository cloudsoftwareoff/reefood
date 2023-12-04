import 'package:flutter/material.dart';

//import 'package:loading_overlay/loading_overlay.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:reefood/components/auth_comp.dart';
import 'package:reefood/constants.dart';
import 'package:reefood/screens/auth/main_auth.dart';
import 'package:reefood/screens/splash/welcome.dart';
import 'package:reefood/services/users/userAuth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, AuthScreen.id);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body:  SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const TopScreenImage(screenImageName: 'logo.png'),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ScreenTitle(title: 'Login'),
                        CustomTextField(
                          textField: TextField(
                              onChanged: (value) {
                                _email = value;
                              },
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                  hintText: 'Email')),
                        ),
                        CustomTextField(
                          textField: TextField(
                            obscureText: true,
                            onChanged: (value) {
                              _password = value;
                            },
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: kTextInputDecoration.copyWith(
                                hintText: 'Password'),
                          ),
                        ),
                        CustomBottomScreen(
                          textButton: 'Login',
                          heroTag: 'login_btn',
                          question: 'Forgot password?',
                          buttonPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {
                              _saving = true;
                            });
                            try {
                              RegistrationResult? result = await AuthService().signInWithEmailAndPassword(_email, _password);
                              
                              if (result != null && result.user != null){
                                // Login success
                                if(context.mounted){
                                   Navigator.popAndPushNamed(context,'/home');
                           
                                }
                              }else if (result!.error != null) {
                // Registration failed
                  if(context.mounted){
                  showAlert(
                                    context: context,
                                    title: 'Login Failed',
                                    desc:
                                        '${result.error}',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }).show();
      }       }
                              
                              
                              
                            
                            } catch (e) {
                              signUpAlert(
                                context: context,
                                onPressed: () {
                                  setState(() {
                                    _saving = false;
                                  });
                                  Navigator.popAndPushNamed(
                                      context, LoginScreen.id);
                                },
                                title: 'Login Failed',
                                desc:
                                    'Something went wrong',
                                btnText: 'Try Now',
                              ).show();
                            }
                          },
                          questionPressed: () {
                            signUpAlert(
                              onPressed: () async {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: _email);
                              },
                              title: 'RESET YOUR PASSWORD',
                              desc:
                                  'Click on the button to reset your password',
                              btnText: 'Reset Now',
                              context: context,
                            ).show();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}