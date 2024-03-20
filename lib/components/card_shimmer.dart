 import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';
import 'package:shimmer/shimmer.dart';

Widget BuildShimmerCard(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        color: scheme.background,
        elevation: 4,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.6,
        ),
      ),
    );
  }
