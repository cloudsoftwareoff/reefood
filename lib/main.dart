import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reefood/app_localizations.dart';
import 'package:reefood/firebase_options.dart';
import 'package:reefood/screens/auth/login_screen.dart';
import 'package:reefood/screens/auth/signup_screen.dart';

import 'package:reefood/wrapper.dart';
import 'package:reefood/screens/home/welcome_page.dart';


void main() async{
    WidgetsFlutterBinding.ensureInitialized(); // <----
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MyApp()
  );
}
class MyApp extends StatelessWidget {

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      supportedLocales: [
    const Locale('en', 'US'), 
   const Locale('fr', 'FR'), 
    const Locale('ar', 'AR'),
  
    ],
     // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files
        AppLocalizations.delegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      // Returns a locale which will be used by the app
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
       
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      locale: Locale('en','US'),
      
     
   initialRoute: '/',
   routes: {
   '/':(context) => Wrapper(),
     
        '/home': (context) => HomePage(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
      
     
   

   },
   
  );


  }
}


