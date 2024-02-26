import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:reefood/constant/colors.dart';
import 'package:reefood/components/alert_dialog.dart';
import 'package:reefood/model/user_profile.dart';
import 'package:reefood/screens/UserProfileEdit/profile_main.dart';

import 'package:reefood/services/users/xUser.dart';

class MyDrawer extends StatelessWidget {
  final BuildContext parentContext;
  const MyDrawer({super.key, required this.parentContext});



  @override
  Widget build(BuildContext context) {


    return Drawer(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Builder(builder: (c) {
            return DrawerHeader(
              decoration: BoxDecoration(
                color: scheme.primary,
                border: Border.all(color: scheme.primary),
              ),
              child: FutureBuilder<UserProfile?>(
                future: UserProfileProvider().userProfileById(FirebaseAuth.instance.currentUser!.uid),
                builder:(context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
              return  Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text('Unknown');
            } else {
                
                UserProfile myself= snapshot.data!;
                return GestureDetector(
                  onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
            );
                  },
                  child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(myself.profilePictureUrl),),
                              ),
                            ),
                            Text(
                            myself.fullname,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                );
            }}
                
              )
              
            
            );
          }),
          true
              ? Column(
                  children: [
                    listTile(
                      context,
                      'Vouchers & offers',
                      Icons.local_offer_outlined,
                      () {
                        // Navigator.pushNamed(context, VoucherScreen.routeName);
                      },
                    ),
                    listTile(
                      context,
                      'Favourites',
                      Icons.favorite_outline_rounded,
                      () {
                        Navigator.pop(context);
                      },
                    ),
                    listTile(
                      context,
                      'Orders & reording',
                      Icons.my_library_books_outlined,
                      () {
                        // Navigator.pushNamed(
                        //     context, OrderHistoryScreen.routeName);
                      },
                    ),
                    listTile(
                      context,
                      'Addresses',
                      Icons.location_on_outlined,
                      () {
                        // Navigator.pushNamed(
                        //   context,
                        //   AddressScreen.routeName,
                        //   arguments: const AddressScreen(
                        //     selectedAddress: null,
                        //   ),
                        // );
                      },
                    ),
                    listTile(
                      context,
                      'Payment methods',
                      Icons.payment_rounded,
                      () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              : const SizedBox(),
          listTile(
            context,
            'Help center',
            Icons.help_outline_outlined,
            () {
              Navigator.pop(context);
            },
          ),
          listTile(
            context,
            'Invite friends',
            Icons.wallet_giftcard_outlined,
            () {
              Navigator.pop(context);
            },
          ),
          Container(
            height: 1,
            color: MyColors.borderColor,
          ),
          listTile(
            context,
            'Settings',
            null,
            () {
              Navigator.pop(context);
            },
          ),
          listTile(
            context,
            'Terms & Conditions / Privacy',
            null,
            () {
              Navigator.pop(context);
            },
          ),
          // ap.isSignedIn
          true
              ? Builder(builder: (c) {
                  return listTile(
                    context,
                    'Log out',
                    null,
                    () {
                      Scaffold.of(c).closeDrawer();
                      showDialog(
                        context: c,
                        builder: (ctx) => MyAlertDialog(
                          title: 'Logging out?',
                          subtitle:
                              'Thanks for stopping by. See you again soon!',
                          action1Name: 'Cancel',
                          action2Name: 'Log out',
                          action1Func: () {
                            Navigator.popAndPushNamed(ctx,'/');
                          },
                          action2Func: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(ctx);
                          },
                        ),
                      );
                    },
                  );
                })
              : const SizedBox(),
        ],
      ),
    );
  }

  ListTile listTile(
      BuildContext context, String text, IconData? icon, VoidCallback onTap) {
    return icon == null
        ? ListTile(
            title: Text(
              text,
              style: const TextStyle(
                color: MyColors.textColor,
                fontSize: 14,
              ),
            ),
            onTap: onTap,
          )
        : ListTile(
            title: Text(
              text,
              style: const TextStyle(
                color: MyColors.textColor,
                fontSize: 14,
              ),
            ),
            leading: Icon(
              icon,
              color: scheme.primary,
            ),
            onTap: onTap,
          );
  }
}