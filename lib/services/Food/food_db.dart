

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reefood/model/food.dart';

class FoodDB extends ChangeNotifier{

List<SaveFood> foodlist=[]; 

Future<List<SaveFood>> queryFood() async {
  final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('food').get();

  
List<SaveFood> foodList = querySnapshot.docs.map((doc) {
  final data = doc.data() as Map<String, dynamic>;

  // Use null-aware operators (??) to handle potential null values
  return SaveFood(
    id: doc['id'] ?? '',
    title: doc['title'] ?? '',
    desc: doc['desc'] ?? '',
    business_id: doc['business_id'] ?? '',
    pickup_time: doc['pickup_time'] ?? '',
    published_at: doc['published_at'] ?? '',
    photo: doc['photo'] ?? '',
    quantity: doc['quantity']?.toDouble() ?? 0.0,
    price: doc['price']?.toDouble() ?? 0.0,
  );
}).toList();

return foodList;


}}