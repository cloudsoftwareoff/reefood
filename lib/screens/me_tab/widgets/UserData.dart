import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/model/user_profile.dart';
import 'package:reefood/screens/me_tab/widgets/chart_row.dart';
import 'package:reefood/screens/me_tab/widgets/shimmer/chart_shimmer.dart';
import 'package:reefood/screens/me_tab/widgets/shimmer/me_tab_shimmer.dart';
import 'package:reefood/screens/me_tab/widgets/shimmer/user_row_shimmer.dart';
import 'package:reefood/screens/me_tab/widgets/user_row.dart';
import 'package:reefood/services/users/XUser.dart';
import 'package:reefood/services/users/userAuth.dart';

class UserData extends StatefulWidget {
  const UserData({
    super.key,
  });

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {

  @override
  Widget build(BuildContext context) {
    return     
    FutureBuilder<UserProfile?>(
      future:UserProfileProvider().userProfileById(FirebaseAuth.instance.currentUser!.uid),
      builder: (context,snapshot) {

         if (snapshot.connectionState == ConnectionState.waiting) {
              return MeShimmer();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: Text("User profile not found"),
              );
            }else {
        
        UserProfile userProfile = snapshot.data!;
            
        return Column(
        
          mainAxisSize: MainAxisSize.max,
        
          children: [
        
            UserRow(me: userProfile),
        
            Divider(
        
              height: 2,
        
              thickness: 1,
        
              color: Color(0xFFE5E7EB),
        
            ),
        
            ChartRow(),
        
          ],
        
        );
            }
      }
    );
  }
}



