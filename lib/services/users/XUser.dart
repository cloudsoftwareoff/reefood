import 'dart:convert';
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
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    _userProfiles = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return UserProfile(
        uid: doc.id,
        fullname: data['fullname'] as String? ?? '', // Handle potential nulls
        profilePictureUrl: data['pfp'] as String? ?? '',
        phoneNumber: data['phone'] as String? ?? '',
        ipLocation: data['ipLocation'] as String? ?? '',
        lastActive: data['last_active'] as Timestamp? ?? Timestamp.now(),
        favoritesFoodID: List<String>.from(data['favoritesFoodID'] ?? []),
        orderHistory: List<String>.from(data['orderHistory'] ?? []),
        preferencesKeywords:
            List<String>.from(data['preferencesKeywords'] ?? []),
        geolocation: GeoPoint(
            // Fetch GeoPoint
            data['geolocation']['latitude'] as double? ?? 0.0,
            data['geolocation']['longitude'] as double? ?? 0.0),
      );
    }).toList();

    notifyListeners();
  }

  Future<UserProfile?> userProfileById(String id) async {
    try {
      // Fetch user profile
    
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: id)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = doc.data();

        // Construct and return UserProfile
        return UserProfile(
          uid: doc.id,
          fullname: data['fullname'] as String? ?? '',
          profilePictureUrl: data['profilePictureUrl'] as String? ?? '',
          phoneNumber: data['phone'] as String? ?? '',
          ipLocation: data['ipLocation'] as String? ?? '',
          lastActive: data['last_active'] as Timestamp? ?? Timestamp.now(),
          favoritesFoodID: List<String>.from(data['favoritesFoodID'] ?? []),
          orderHistory: List<String>.from(data['orderHistory'] ?? []),
          preferencesKeywords:
              List<String>.from(data['preferencesKeywords'] ?? []),
          geolocation: GeoPoint(
            data['geolocation'].latitude as double? ?? 0.0,
            data['geolocation'].longitude as double? ?? 0.0,
          ),
        );
      } else {
        return null;
      }
    } catch (error) {
      print('Error fetching user profile: $error');
      rethrow;
    }
  }

  Future<UserProfile?> fetchCachedUserProfile(String userId) async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Check for cached data
    final cachedProfileJson = prefs.getString('user_$userId');
    if (cachedProfileJson != null) {
      return UserProfile.fromJson(
          jsonDecode(cachedProfileJson)); // Reconstruct the object
    }

    // 2. Fetch from Firestore
    final profile = await userProfileById(userId);

    // 3. Cache the data
    prefs.setString('user_$userId', jsonEncode(profile!.toJson()));

    return profile;
  }

  Future<void> addUserToFirestore(UserProfile newUser) async {
    try {
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      await usersCollection.doc(newUser.uid).set(newUser.toJson());
      // cache user
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('user_${newUser.uid}', jsonEncode(newUser.toJson()));
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }

  Future<Result> updateUserProfile(UserProfile updatedUser) async {
    try {
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Use the document ID to update the existing user data
      await usersCollection.doc(updatedUser.uid).update(updatedUser.toJson());

      // Find and update the local list of user profiles
      int index =
          _userProfiles.indexWhere((user) => user.uid == updatedUser.uid);
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

  static Future<void> updateLocationInFirestore(
      String uid, String location) async {
    try {
      final DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(uid);

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
        'device_name': Platform.isAndroid
            ? androidInfo?.model
            : (Platform.isIOS ? iosInfo?.model : 'Unknown'),
      });

      print(
          'Location, last active, and device name updated in Firestore for UID: $uid');
    } catch (e) {
      print('Error updating location in Firestore: $e');
    }
  }

  Future<UserProfile?> getCachedUserByUid(String uid) async {
    // Logic to retrieve the user from cache or fetch it if not available

    return userProfileById(uid);
  }
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
