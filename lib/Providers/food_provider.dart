import 'package:flutter/material.dart';
import 'package:reefood/model/food.dart';
import 'package:reefood/services/Food/food_db.dart';

class FoodProvider extends ChangeNotifier {
  List<SaveFood> _foodList = [];

  List<SaveFood> get foodList => _foodList;

  // Initialize _foodList during declaration
  FoodProvider() {
    fetchFoodList();
  }

  Future<void> fetchFoodList() async {
    try {
      _foodList = await FoodDB().queryFood();
      notifyListeners();
    } catch (error) {
      print('Error fetching food list: $error');
      // Handle error as per your app's requirement
    }
  }
}
