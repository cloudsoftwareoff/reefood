import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/model/user_profile.dart';

class UserRow extends StatelessWidget {
  final UserProfile me;
  const UserRow({
    super.key,
    required this.me
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
    
      padding: EdgeInsets.all(16),
    
      child: Row(
    
        mainAxisSize: MainAxisSize.max,
    
        children: [
    
          Container(
    
            width: 72,
    
            height: 72,
    
            decoration: BoxDecoration(
    
              color: scheme.secondary,
    
              borderRadius: BorderRadius.circular(12),
    
              border: Border.all(
    
                color: scheme.primary,
    
                width: 2,
    
              ),
    
            ),
    
            child: Padding(
    
              padding: EdgeInsets.all(2),
    
              child: ClipRRect(
    
                borderRadius: BorderRadius.circular(8),
    
                child: CachedNetworkImage(
    
                  fadeInDuration: Duration(milliseconds: 500),
    
                  fadeOutDuration: Duration(milliseconds: 500),
    
                  imageUrl:
    
                      me.pfp,
    
                  width: 44,
    
                  height: 44,
    
                  fit: BoxFit.cover,
    
                ),
    
              ),
    
            ),
    
          ),
    
          Expanded(
    
            child: Padding(
    
              padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 4),
    
              child: Column(
    
                mainAxisSize: MainAxisSize.max,
    
                crossAxisAlignment: CrossAxisAlignment.start,
    
                children: [
    
                  Text(
    
                    me.fullname,
    
                    style:
    
                        TextStyle(
    
                              fontFamily: 'Outfit',
    
                              color: Color(0xFF15161E),
    
                              fontSize: 22,
    
                              fontWeight: FontWeight.bold,
    
                            ),
    
                  ),
    
                  Padding(
    
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
    
                    child: Text(
    
                      FirebaseAuth.instance.currentUser!.email.toString(),
    
                      style:
    
                          TextStyle(
    
                                fontFamily: 'Plus Jakarta Sans',
    
                                color: Color(0xFF606A85),
    
                                fontSize: 14,
    
                                fontWeight: FontWeight.w500,
    
                              ),
    
                    ),
    
                  ),
    
                ],
    
              ),
    
            ),
    
          ),
    
        ],
    
      ),
    
    );
  }
}