import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class UserRowShimmer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Shimmer.fromColors( // Shimmer for profile image
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container( 
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.grey, 
                borderRadius: BorderRadius.circular(12), 
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors( // Shimmer for name
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 120, // Adjust width based on expected name length
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.grey, 
                      borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Shimmer.fromColors( // Shimmer for email
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: 180, 
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey, 
                      borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
