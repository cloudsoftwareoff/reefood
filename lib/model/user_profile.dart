import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
   String fullname;
   String pfp;
   String bio;
   String phone;
  final String location;
  final Timestamp last_active;

  UserProfile({
    required this.uid,
    required this.fullname,
    required this.pfp,
    required this.bio,
    required this.phone,
    required this.location,
    required this.last_active
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullname': fullname,
      'pfp': pfp,
      'bio': bio,
      'phone': phone,
      'location': location,
    };
  }
  static Future<UserProfile?> getCachedUserByUid(String uid) async {
    // Your logic to retrieve the user from cache or fetch it if not available
    // ...

    return null; // Placeholder, replace with your actual logic
  }
}
