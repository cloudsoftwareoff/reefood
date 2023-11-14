import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reefood/components/auth_comp.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: const Center(
          child: ScreenTitle(
            title: 'HomePage',
          ),
        ),
      ),
    );
  }
}