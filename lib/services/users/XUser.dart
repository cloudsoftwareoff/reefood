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
      last_active: data['last_active'] ?? Timestamp.now(),
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

  Future<Result> updateUserProfile(UserProfile updatedUser) async {
    try {
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      
      // Use the document ID to update the existing user data
      await usersCollection.doc(updatedUser.uid).update(updatedUser.toJson());

      // Find and update the local list of user profiles
      int index = _userProfiles.indexWhere((user) => user.uid == updatedUser.uid);
      if (index != -1) {
        _userProfiles[index] = updatedUser;
        notifyListeners();
      }

      print('User updated in Firestore: ${updatedUser.uid}');
      
      return Result.success('User updated successfully');
    } catch (e) {
      print('Error updating user in Firestore: $e');
      return Result.error('Error updating user: $e');
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
    
    return userProfileById(uid);
    // if (cachedUser != null) {
    //   return cachedUser;
    // } else {
    //   // Fetch the user from Firestore or another source
    //   // For example: UserProfile user = await fetchUserFromFirestore(uid);
    //   // Cache the user
    //   // UserProfile.saveUserToCache(user);
    //   return null; // Return the fetched user or null if not found
    // }
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

class Result {
  final bool isSuccess;
  final String message;

  Result._(this.isSuccess, this.message);

  factory Result.success(String message) {
    return Result._(true, message);
  }

  factory Result.error(String message) {
    return Result._(false, message);
  }
}