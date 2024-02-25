import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';

import 'package:reefood/components/auth_comp.dart';
import 'package:reefood/components/dropdown.dart';
import 'package:reefood/screens/auth/login_screen.dart';
import 'package:reefood/screens/auth/signup_screen.dart';
import 'package:reefood/services/users/userAuth.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  static String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TopScreenImage(screenImageName: 'logo.png'),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, left: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const ScreenTitle(title: 'ReeFood'),
                      const Text(
                        'Discover a new way to reduce waste and save resources.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Hero(
                        tag: 'login_btn',
                        child: CustomButton(
                          buttonText: 'Login',
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Hero(
                        tag: 'signup_btn',
                        child: CustomButton(
                          buttonText: 'Sign Up',
                          isOutlined: true,
                          onPressed: () {
                            Navigator.pushNamed(context, SignUpScreen.id);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Sign up using',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                    
                              //_showBottomSheet(context);
                            },
                            icon: CircleAvatar(
                              radius: 25,
                              child: Image.asset(
                                  'assets/img/facebook.png'),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              //AuthService().SignInGoogle();
                            },
                            icon: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child:
                                  Image.asset('assets/img/google.png'),
                            ),
                          ),
                        
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      
    );
  }
}
 void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return // Generated code for this Column Widget...
// Generated code for this Column Widget...
Align(
  alignment: AlignmentDirectional(0, -1),
  child: Padding(
    padding: EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropDown(dropListModel: 
         DropListModel([
  OptionItem(id: "1", title: "Ariana"),
  OptionItem(id: "2", title: "Beja"),
  OptionItem(id: "3", title: "Ben Arous"),
  OptionItem(id: "4", title: "Bizerte"),
  OptionItem(id: "5", title: "Gabes"),
  OptionItem(id: "6", title: "Gafsa"),
  OptionItem(id: "7", title: "Jendouba"),
  OptionItem(id: "8", title: "Kairouan"),
  OptionItem(id: "9", title: "Kasserine"),
  OptionItem(id: "10", title: "Kebili"),
  OptionItem(id: "11", title: "Kef"),
  OptionItem(id: "12", title: "Mahdia"),
  OptionItem(id: "13", title: "Manouba"),
  OptionItem(id: "14", title: "Medenine"),
  OptionItem(id: "15", title: "Monastir"),
  OptionItem(id: "16", title: "Nabeul"),
  OptionItem(id: "17", title: "Sfax"),
  OptionItem(id: "18", title: "Sidi Bouzid"),
  OptionItem(id: "19", title: "Siliana"),
  OptionItem(id: "20", title: "Sousse"),
  OptionItem(id: "21", title: "Tataouine"),
  OptionItem(id: "22", title: "Tozeur"),
  OptionItem(id: "23", title: "Tunis"),
  OptionItem(id: "24", title: "Zaghouan"),
])

        ),
        Align(
          alignment: AlignmentDirectional(-1, 0),
          child: Checkbox(
            value:  true,
            onChanged: (newValue) async {
             
            },
            activeColor: Colors.blue, // Set your desired color
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-1, 0),
          child: Checkbox(
            value:  true,
            onChanged: (newValue) async {
              //setState(() => _model.checkboxValue2 = newValue!);
            },
            activeColor: Colors.blue, // Set your desired color
          ),
        ),
        ElevatedButton(
          onPressed: () {
            print('Button pressed ...');
          },
          style: ElevatedButton.styleFrom(
          
            primary: scheme.primary, // Set your desired color
            padding: EdgeInsets.all(16),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Button',
            style: TextStyle(
              fontFamily: 'Raptor Family',
              
            ),
          ),
        ),
      ],
    ),
  ),
)

;
      },
    );
  }