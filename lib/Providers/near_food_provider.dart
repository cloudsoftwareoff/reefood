import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reefood/functions/distance.dart';
import 'package:reefood/model/business.dart';


class NearBusinessProvider extends ChangeNotifier {
  Future<List<Business>> fetchBusinessNearUser(double userLatitude, double userLongitude, {double maxDistance = 20}) async {
    try {
      // Fetch business items from Firestore
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('business').get();

      List<Business> businessList = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        // Create a Business object from Firestore document data
        return Business(
          id: doc['id'] ?? '',
          name: doc['name'] ?? '',
          icon: doc['icon'] ?? '',
          opentime: doc['opentime'] ?? '',
          latitude: doc['latitude']?.toDouble() ?? 0.0,
          longitude: doc['longitude']?.toDouble() ?? 0.0,
        );
      }).toList();

      // Filter business items based on their location relative to the user's position
      final List<Business> businessNearUser = businessList.where((businessItem) {
        double distance = calculateDistance(
          businessItem.latitude,
          businessItem.longitude,
          userLatitude,
          userLongitude,
        );
        return distance <= maxDistance;
      }).toList();

      return businessNearUser;
    } catch (error) {
      print('Error fetching businesses near user: $error');
      // Handle error as needed
      return [];
    }
  }
}
