import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/screens/auth/widgets/checkbox_term.dart';
import 'package:reefood/screens/auth/widgets/email_field.dart';
import 'package:reefood/screens/auth/widgets/forget_password.dart';
import 'package:reefood/screens/auth/widgets/name_field.dart';
import 'package:reefood/screens/auth/widgets/password_field.dart';
import 'package:reefood/screens/auth/widgets/auth_func.dart';
import 'package:reefood/screens/auth/widgets/social_login.dart';

bool loading = false;
bool isLogin = true;




class MainAuthScreen extends StatefulWidget {
  final bool loginRequest;
  const MainAuthScreen({super.key, required this.loginRequest});

  @override
  State<MainAuthScreen> createState() => _MainAuthScreenState();
}

class _MainAuthScreenState extends State<MainAuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin = widget.loginRequest;

  }
 
  bool isChecked=true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: () => {FocusScope.of(context).unfocus()},
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: loading,
          child: Form(
            key: _formKey,
            child: SafeArea(
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
                            EmailTextField(controller: _emailController),
                            Visibility(
                                visible: !isLogin,
                                child: NameField(controller: _nameController)),
                            PasswordField(
                              controller: _passwordController,
                            ),
                            Visibility(
                              visible: !isLogin,
                              child: 
                              TermAndCondition()
                            ),
                            SignInBtn(
                              email_controller: _emailController,
                              pass_controller: _passwordController,
                              name_controller: _nameController,
                            ),
                            Visibility(
                                visible: isLogin, child: ForgetPassword()),
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class SignInBtn extends StatefulWidget {
  final TextEditingController? email_controller;
  final TextEditingController? pass_controller;
  final TextEditingController? name_controller;

  const SignInBtn(
      {Key? key,
      required this.email_controller,
      required this.pass_controller,
      required this.name_controller,
    
      })
      : super(key: key);

  @override
  State<SignInBtn> createState() => _SignInBtnState();
}

class _SignInBtnState extends State<SignInBtn> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
          child: ElevatedButton(
            onPressed: () async {

              //  print('email${widget.email_controller!.text},password${widget.pass_controller!.text}');

              loading=true;
              _MainAuthScreenState().build(context);
              
              if (isLogin) {
              await  signIn(
                    email: widget.email_controller!.text,
                    password: widget.pass_controller!.text,
                    context: context);
              } else {

              await  createAccount(
                  email: widget.email_controller!.text,
                  name: widget.name_controller!.text, 
                  password: widget.pass_controller!.text, 
                  context: context);
              }
              loading=false;
              _MainAuthScreenState().build(context);
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: scheme.primary,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              fixedSize: Size(230, 52),
            ),
          )),
    );
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
      height: MediaQuery.of(context).size.height / 3.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.secondary, Color(0xFFEE8B60)],
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
                  borderRadius:
                      BorderRadius.circular(50), // Adjust for desired roundness
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
                style: TextStyle(
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
