import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  String fullname;
  String profilePictureUrl;
  final String ipLocation;
  final Timestamp lastActive;
  final Timestamp createdAt;
  String phoneNumber;
  List<String> orderHistory;
  List<String> favoritesFoodID;
  List<String> preferencesKeywords;
  GeoPoint geolocation;

  UserProfile({
    //required
    required this.uid,
    required this.fullname,
    required this.profilePictureUrl,
    required this.ipLocation,
    required this.lastActive,
    // optional
    this.phoneNumber = "", // default value
    this.orderHistory = const [],
    this.favoritesFoodID = const [],
    this.preferencesKeywords = const [],
    this.geolocation = const GeoPoint(0, 0),
   // this.createdAt = const Timestamp.now()
  }): createdAt = Timestamp.now();

// From JSON factory constructor
  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        uid: json['uid'] as String,
        fullname: json['fullname'] as String,
        profilePictureUrl: json['profilePictureUrl'] as String,
        phoneNumber: json['phone'] as String,
        ipLocation: json['ipLocation'] as String,
        lastActive: json['lastActive'] as Timestamp,
        favoritesFoodID: List<String>.from(json['favoritesFoodID'] ?? []),
        orderHistory: List<String>.from(json['orderHistory'] ?? []),
        preferencesKeywords:
            List<String>.from(json['preferencesKeywords'] ?? []),
        geolocation: GeoPoint(json['geolocation']['latitude'] as double? ?? 0.0,
            json['geolocation']['longitude'] as double? ?? 0.0),
      );

  // To JSON encoder
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'fullname': fullname,
        'profilePictureUrl': profilePictureUrl,
        'phone': phoneNumber,
        'ipLocation': ipLocation,
        'lastActive': lastActive,
        'favoritesFoodID': favoritesFoodID,
        'orderHistory': orderHistory,
        'preferencesKeywords': preferencesKeywords,
        'geolocation': geolocation,
      };
}
