import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/model/business.dart';

class BusinessCard extends StatelessWidget {
  final Business business;

  const BusinessCard({required this.business, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // Fixed height for the card
      child: Card(
        color: scheme.background,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Business Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child: ClipOval(
                  child: Image.network(
                    business.icon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16), // Add spacing between icon and details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Business Name
                  Text(
                    business.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8), // Add spacing between name and open time
                  // Business Open Time
                  Text(
                    'Open Time: ${business.opentime}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
