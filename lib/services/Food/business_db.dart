import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reefood/model/business.dart';

class BusinessDB extends ChangeNotifier {
  List<Business> businessList = [];

  Future<List<Business>> queryFood() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('business').get();

    List<Business> businessList = querySnapshot.docs.map((doc) {
    
        return Business(
        id: doc['id'] ?? '',
        name: doc['name'] ?? '',
        icon: doc['icon'] ?? '',
        opentime: doc['opentime'] ?? '',
        latitude: doc['latitude'] ?? 0,
        longitude: doc['longitude'] ?? 0
      );
    }).toList();

    return businessList;
  }

  Future<Business> getBusinessById(String businessId) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('business')
            .where('id', isEqualTo: businessId)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      

      return Business(
        id: doc['id'] ?? '',
        name: doc['name'] ?? '',
        icon: doc['icon'] ?? '',
        opentime: doc['opentime'] ?? '',
          latitude: doc['latitude'] ?? 0,
        longitude: doc['longitude'] ?? 0
      );
    } else {
      // Return null if business with the given ID is not found
       
      return Business(
        id: 'null',
        name: 'doesnt exist',
        icon: 'null',
        opentime: 'null',
        latitude: 0,
        longitude: 0
      );
      ;
    }
  }
}
