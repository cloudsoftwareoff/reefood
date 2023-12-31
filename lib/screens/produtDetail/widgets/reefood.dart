import 'package:flutter/material.dart';

class Reefood extends StatelessWidget {
  const Reefood({
    Key? key,
  }) : super(key: key);

  final imageUrl =
      'https://gtswiki.gt-beginners.net/decal/png/16/52/35/7278450332114355216_1.png';

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -19,
      right: 0.0,
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/img/logo.png',
        image: imageUrl,
        width: 150,
        height: 72,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}