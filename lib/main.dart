import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:reefood/Providers/business.provider.dart';
import 'package:reefood/Providers/food_provider.dart';
import 'package:reefood/Providers/near_food_provider.dart';
import 'package:reefood/Providers/user_Provider.dart';
import 'package:reefood/app_localizations.dart';
import 'package:reefood/constant/theme.dart';
import 'package:reefood/firebase_options.dart';
import 'package:reefood/screens/UserProfileEdit/profile_main.dart';
import 'package:reefood/screens/auth/auth_screen.dart';
import 'package:reefood/screens/mainscreen/mainscreen.dart';
import 'package:reefood/screens/me_tab/userprofile_page.dart';
import 'package:reefood/services/users/userdb.dart';
import 'package:reefood/wrapper.dart';
import 'package:reefood/Providers/liked_food.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <----
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => CurrentUserProvider()),
      ChangeNotifierProvider(create: (context) => NearBusinessProvider()),
      ChangeNotifierProvider(create: (context) => FoodProvider()),
      ChangeNotifierProvider(create: (context) => LikedFoodIdsProvider()),
      ChangeNotifierProvider(create: (context) => BusinessProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myAppTheme,
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('fr', 'FR'),
        const Locale('ar', 'AR'),
      ],
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: const [
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
      locale: const Locale('en', 'US'),

      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
        '/home': (context) => MainScreenApp(),
        '/signup': (context) => MainAuthScreen(
              loginRequest: false,
            ),
        '/login': (context) => MainAuthScreen(
              loginRequest: true,
            ),
        'me': (context) => ME(),
        '/editprofile': (context) => EditProfilePage(),
      },
    );
  }
}
