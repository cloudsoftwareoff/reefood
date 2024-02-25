import 'package:flutter/material.dart';
import 'package:reefood/screens/me_tab/widgets/shimmer/chart_shimmer.dart';
import 'package:reefood/screens/me_tab/widgets/shimmer/user_row_shimmer.dart';

class MeShimmer extends StatefulWidget {
  const MeShimmer({super.key});

  @override
  State<MeShimmer> createState() => _MeShimmerState();
}

class _MeShimmerState extends State<MeShimmer> {
  @override
  Widget build(BuildContext context) {
    return  Column(
        
          mainAxisSize: MainAxisSize.max,
        
          children: [
        
            UserRowShimmer(),
        
            Divider(
        
              height: 2,
        
              thickness: 1,
        
              color: Color(0xFFE5E7EB),
        
            ),
        
            ChartRowShimmer(),
        
          ],
        
        );
  }
}