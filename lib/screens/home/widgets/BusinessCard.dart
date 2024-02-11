import 'package:flutter/material.dart';
import 'package:reefood/colors.dart';
import 'package:reefood/model/business.dart';

class BusinessCard extends StatelessWidget {
  final Business business;

  const BusinessCard({required this.business, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
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
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    business.icon,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  business.name,
                ),
                Text(
                  business.opentime,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
