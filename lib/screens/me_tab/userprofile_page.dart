import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reefood/screens/me_tab/widgets/UserData.dart';
import 'package:reefood/screens/me_tab/widgets/usersettings.dart';

class ME extends StatefulWidget {
  const ME({super.key});

  @override
  State<ME> createState() => _MEState();
}

class _MEState extends State<ME> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [UserData(), ProfileSettings()],
        ),
      ),
    );
  }
}
