// //User Class
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserProfile {
//   final String uid;
//   final String fullname;
//   final String pfp;
//   final String bio;
//   final String phone;
//   final String location;

//   UserProfile({
//     required this.uid,
//     required this.fullname,
//     required this.pfp,
//     required this.bio,
//     required this.phone,
//     required this.location,
//   });


//  static Map<String, UserProfile> _cachedUsers = {};
//   static Set<String> _fetchAttempted = {}; 
//    static UserProfile? currentUserProfile;

//   factory UserProfile.fromJson(Map<String, dynamic> json) {
//     return UserProfile(
//       uid: json['uid'] as String,
//       fullname: json['fullname'] as String,
//       pfp: json['pfp'] as String,
//       bio: json['bio'] as String,
//       phone: json['phone'] as String,
//       location: json['location'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'uid': uid,
//       'fullname': fullname,
//       'pfp': pfp,
//       'bio': bio,
//       'phone': phone,
//       'location': location,
//     };
//   }



//   static Future<List<UserProfile>> fetchAllUsers() async {
//     try {
//       final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
//       QuerySnapshot querySnapshot = await usersCollection.get();

//       List<UserProfile> userList = querySnapshot.docs.map((doc) {
//         return UserProfile.fromJson(doc.data() as Map<String, dynamic>);
//       }).toList();
//        final currentUser = FirebaseAuth.instance.currentUser;
//       for (var user in userList) {
//         _cachedUsers[user.uid] = user;
//         if (user.uid == currentUser!.uid){
//           currentUserProfile = user;
//         }
//       }

//       // save current user
  
//       return userList;
//     } catch (e) {
//       print('Error fetching all users from Firestore: $e');
//       return [];
//     }
//   }

//   static Future<UserProfile?> getCachedUserByUid(String uid) async {
//   UserProfile? cachedUser = _cachedUsers[uid];

//   if (cachedUser != null) {
//     return cachedUser;
//   } else if (!_fetchAttempted.contains(uid)) {
//     // Check if we have already attempted to fetch this user
//      {
//       _fetchAttempted.add(uid); // Mark that we've attempted to fetch this user
//       // Fetch the user from Firestore
//       List<UserProfile?> user = await fetchAllUsers();
     
      
//     } 
//   }else {
//       // We've already attempted to fetch this user, and they don't exist in Firestore
//       return null;
//     }
//  // return null;
// }


//   static Future<void> saveUserDataToFirestore(UserProfile userProfile) async {
//     try {
//       final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
//       await usersCollection.doc(userProfile.uid).set(userProfile.toJson());
//       print('User data saved to Firestore for UID: ${userProfile.uid}');
//     } catch (e) {
//       print('Error saving user data to Firestore: $e');
//     }
//   }

//   static Future<void> updateLocationInFirestore(String uid, String location) async {
//     try {
//       final DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);
//       await userDocRef.update({
//         'location': location,
//         'last_active': FieldValue.serverTimestamp(),
//       });
//       print('Location updated in Firestore for UID: $uid');
//     } catch (e) {
//       print('Error updating location in Firestore: $e');
//     }
//   }
// }

// String getFormattedUsername(UserProfile? userProfile) {
//   if (userProfile != null && userProfile.fullname != null) {
//     if (userProfile.fullname.length <= 10) {
//       return userProfile.fullname;
//     } else {
//       return userProfile.fullname.substring(0, 10) + '...';
//     }
//   }
//   return ''; // Handle null cases or return an empty string as needed
// }
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reefood/model/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileProvider extends ChangeNotifier {
  List<UserProfile> _userProfiles = [];

  List<UserProfile> get userProfiles => _userProfiles;

  Future<void> fetchUserProfiles() async {
    // Fetch user profiles from Firestore
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('users').get();

    _userProfiles = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return UserProfile(
        uid: doc.id,
        fullname: data['fullname'],
        pfp: data['pfp'],
        bio: data['bio'],
        phone: data['phone'],
        location: data['location'],
        last_active: data['last_active']
      );
    }).toList();

    notifyListeners();
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
      last_active: data['last_active'],
    );
  } else {
    // Return null if no user with the specified ID is found
    return null;
  }
}



  Future<void> addUserToFirestore(UserProfile newUser) async {
    try {
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      await usersCollection.doc(newUser.uid).set(newUser.toJson());
      print('User added to Firestore: ${newUser.uid}');
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }



  static Future<void> updateLocationInFirestore(String uid, String location) async {
    try {
      final DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

      // Initialize device info
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo? androidInfo;
      IosDeviceInfo? iosInfo;

      // Try to get Android or iOS device info
      try {
        if (Platform.isAndroid) {
          androidInfo = await deviceInfo.androidInfo;
        } else if (Platform.isIOS) {
          iosInfo = await deviceInfo.iosInfo;
        }
      } catch (e) {
        print('Error getting device info: $e');
      }

      // Update location, last_active, and device_name
      await userDocRef.update({
        'location': location,
        'last_active': FieldValue.serverTimestamp(),
        'device_name': Platform.isAndroid ? androidInfo?.model : (Platform.isIOS ? iosInfo?.model : 'Unknown'),
      });

      print('Location, last active, and device name updated in Firestore for UID: $uid');
    } catch (e) {
      print('Error updating location in Firestore: $e');
    }
  }

  Future<UserProfile?> getCachedUserByUid(String uid) async {
    // Logic to retrieve the user from cache or fetch it if not available
    UserProfile? cachedUser = await UserProfile.getCachedUserByUid(uid);

    if (cachedUser != null) {
      return cachedUser;
    } else {
      // Fetch the user from Firestore or another source
      // For example: UserProfile user = await fetchUserFromFirestore(uid);
      // Cache the user
      // UserProfile.saveUserToCache(user);
      return null; // Return the fetched user or null if not found
    }
  }

  //  static Future<UserProfile?> getCurrentUserFromPrefs() async {
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final String? currentUserId = prefs.getString('currentUserId');

  //     if (currentUserId != null) {
  //       return getCachedUserByUid(currentUserId);
  //     }

  //     return null;
  //   } catch (e) {
  //     print('Error getting current user from SharedPreferences: $e');
  //     return null;
  //   }
  // }
   
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
// AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
// print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"

// IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
// print('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
}
