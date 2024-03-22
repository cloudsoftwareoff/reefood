import 'package:flutter/material.dart';

class LikedFoodIdsProvider extends ChangeNotifier {
  List<String> _likedFoodIds = [];

  List<String> get likedFoodIds => _likedFoodIds;
  

  void updateLikedFoodIds(List<String> ids) {
    _likedFoodIds = ids;
    notifyListeners();
  }
}
