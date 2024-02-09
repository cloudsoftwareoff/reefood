import 'package:flutter/material.dart';
import 'package:reefood/colors.dart';

class BusinessCard extends StatefulWidget {
  const BusinessCard({super.key});

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  @override
  Widget build(BuildContext context) {
    return 
Align(
  alignment: AlignmentDirectional(0, 0),
  child: Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color:scheme.background,
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
            width: 120,
            height: 120,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              'https://picsum.photos/seed/427/600',
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'Hello World',
            
          ),
          Text(
            'Hello World',
            
          ),
        ],
      ),
    ),
  ),
)
;
  }
}