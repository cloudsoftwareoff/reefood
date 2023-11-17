import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reefood/model/user_profile.dart';
import 'package:reefood/services/users/XUser.dart';
import 'package:reefood/services/users/userAuth.dart';
// import 'package:reefood/components/auth_comp.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'welcome_screen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 late UserProfile me;

  @override
  void initState() {
    super.initState();
   // _userProfileFuture =
       // UserProfileProvider().userProfileById(FirebaseAuth.instance.currentUser!.uid);
  }
  Future<UserProfile?> userProfileById(String id) async {
  print("$id");
  // Fetch a specific user profile from Firestore based on the provided ID
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: id).get();

  if (querySnapshot.docs.isNotEmpty) {
    final doc = querySnapshot.docs.first;
    final data = doc.data();
    
    // Return the UserProfile for the user with the specified ID
    return UserProfile(
      uid: doc.id,
      fullname: data['fullname'],
      pfp: data['pfp'],
      bio: data['bio'],
      phone: data['phone'],
      location: data['location'],
      last_active: Timestamp.now(),
    );
  } else {
    // Return null if no user with the specified ID is found
    return null;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: SafeArea(
          child: FutureBuilder<UserProfile?>(
            future: userProfileById(FirebaseAuth.instance.currentUser!.uid),
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
                return Center(
                  child: Text("User profile not found"),
                );
              } else {
                UserProfile userProfile = snapshot.data!;
                String name = userProfile.fullname;
        
                return Column(
                  children: [
                   GestureDetector(
                    onTap:() {
                       Navigator.pushNamed(context, '/editprofile');
                    },
                    child: Text(name),
                   ),
                    GestureDetector(
                      child: TextButton(
                        onPressed: () {
                          AuthService().signOut();
                        },
                        child: Text("Log out"),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
