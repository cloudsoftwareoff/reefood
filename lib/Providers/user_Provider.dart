import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reefood/model/user_profile.dart';
import 'package:reefood/services/users/userdb.dart';

class CurrentUserProvider extends ChangeNotifier {
  UserProfile? _currentUser;

  UserProfile? get currentUser => _currentUser;

  CurrentUserProvider() {
    fetchCurrentUser(FirebaseAuth.instance.currentUser!.uid);
  }
  // Function to fetch current user data
  Future<void> fetchCurrentUser(String userId) async {
    try {
      // Fetch user profile from Firestore
      final userProfile = await UserProfileProvider().userProfileById(userId);

      // Set current user
      _currentUser = userProfile;

      notifyListeners();
    } catch (error) {
      print('Error fetching current user: $error');
    }
  }
}
