import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChartRowShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container( // Placeholder for Icon
                        width: 44, 
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container( // Placeholder for primary text
                        width: 70,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4)
                        ),
                      ), 
                      const SizedBox(height: 4),
                      Container( // Placeholder for secondary text
                        width: 100,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
       
      ],
    );
  }
}

