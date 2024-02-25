import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/screens/auth/widgets/email_field.dart';
import 'package:reefood/screens/auth/widgets/forget_password.dart';
import 'package:reefood/screens/auth/widgets/password_field.dart';
import 'package:reefood/screens/auth/widgets/signin_btn.dart';
import 'package:reefood/screens/auth/widgets/social_login.dart';


class SignIn extends StatefulWidget {
  const SignIn
({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  @override
  Widget build(BuildContext context) {
    return 
GestureDetector(
  onTap: () => {},
  child:const Scaffold(
    
    backgroundColor: Colors.white,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            SignInTopSplash(),

            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EmailTextField(),
                    PasswordField(),
                    SignInBtn(),
                    ForgetPassword(),
                    SocialLogin(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
)
;
  }
}






class SignInTopSplash extends StatelessWidget {
  const SignInTopSplash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.secondary,
            Color(0xFFEE8B60)
          ],
          stops: [0, 0.5, 1],
          begin: AlignmentDirectional(-1, -1),
          end: AlignmentDirectional(1, 1),
        ),
      ),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0x00FFFFFF), Colors.white],
            stops: [0, 1],
            begin: AlignmentDirectional(0, -1),
            end: AlignmentDirectional(0, 1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xCCFFFFFF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50), // Adjust for desired roundness
                  child: Image.asset(
                    'assets/img/logo.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: Text(
                'Sign In',
                style:
                    TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF101213),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
              child: Text(
                'Use the account below to sign in.',
                style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}