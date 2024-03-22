import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reefood/components/display_pfp_edit.dart';
import 'package:reefood/model/user_profile.dart';

import 'package:reefood/screens/UserProfileEdit/pages/edit_email.dart';
import 'package:reefood/screens/UserProfileEdit/pages/edit_image.dart';
import 'package:reefood/screens/UserProfileEdit/pages/edit_name.dart';
import 'package:reefood/screens/UserProfileEdit/pages/edit_phone.dart';
import 'package:reefood/services/users/userdb.dart';

// "Edit Profile" Screen
class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final String? myemail = FirebaseAuth.instance.currentUser!.email;

    return Scaffold(
      body: FutureBuilder<UserProfile?>(
          future: UserProfileProvider()
              .getCachedUserByUid(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text("User profile not found"),
              );
            } else {
              UserProfile userProfile = snapshot.data!;
              return Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    toolbarHeight: 10,
                  ),
                  const Center(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(64, 105, 225, 1),
                            ),
                          ))),
                  InkWell(
                      onTap: () {
                        navigateSecondPage(EditImagePage(
                            pfpUrl: userProfile.profilePictureUrl));
                      },
                      child: DisplayImage(
                        imagePath: userProfile.profilePictureUrl,
                        onPressed: () {},
                      )),
                  buildUserInfoDisplay(
                      userProfile.fullname,
                      'Name',
                      EditNameFormPage(
                        myself: userProfile,
                      )),
                  buildUserInfoDisplay(
                      userProfile.phoneNumber,
                      'Phone',
                      EditPhoneFormPage(
                        phoneNum: userProfile.phoneNumber,
                      )),
                  buildUserInfoDisplay(
                      myemail!, 'Email', const EditEmailFormPage()),
                ],
              );
            }
          }),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
