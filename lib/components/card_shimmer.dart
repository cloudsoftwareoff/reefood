import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFoodCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Handle onTap
      },
      child: Card(
        color: Colors.grey[300], // Placeholder color
        elevation: 14,
        child: SizedBox(
          height: height * 0.22,
          width: width * 0.6,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.12,
                      width: double.infinity,
                      color: Colors.grey[300], // Placeholder color
                    ),
                    Positioned(
                      top: 15,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400], // Placeholder color
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 14,
                            width: 80,
                            color: Colors.white, // Placeholder color
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 10,
                      child: Container(
                        height: 28,
                        width: 28,
                        color: Colors.grey[400], // Placeholder color
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            color: Colors.grey[400], // Placeholder color
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 18,
                            width: 100,
                            color: Colors.grey[400], // Placeholder color
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Container(
                        height: 18,
                        width: 200,
                        color: Colors.grey[400], // Placeholder color
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 0, 0),
                  child: Row(
                    children: [
                      Container(
                        height: 15,
                        width: 50,
                        color: Colors.grey[400], // Placeholder color
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 19,
                            width: 40,
                            color: Colors.grey[400], // Placeholder color
                          ),
                          SizedBox(width: 5),
                          Container(
                            height: 15,
                            width: 20,
                            color: Colors.grey[400], // Placeholder color
                          ),
                          SizedBox(width: 5),
                          Container(
                            height: 10,
                            width: 20,
                            color: Colors.grey[400], // Placeholder color
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                      Spacer(),
                      Container(
                        height: 20,
                        width: 40,
                        color: Colors.grey[400], // Placeholder color
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
