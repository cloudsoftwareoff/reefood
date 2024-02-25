import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/model/business.dart';

class BusinessCard extends StatelessWidget {
  final Business business;

  const BusinessCard({required this.business, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.2;

    return Container(
      height: cardHeight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: scheme.background,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,  // Adjust the width as needed
                  height: 80,  // Adjust the height as needed
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    business.icon,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8),  // Add some spacing between the image and text
                Text(
                  business.name,
                  style: TextStyle(fontSize: 16),  // Adjust the font size as needed
                ),
                Text(
                  business.opentime,
                  style: TextStyle(fontSize: 14),  // Adjust the font size as needed
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
