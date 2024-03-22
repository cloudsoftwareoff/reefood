import 'package:flutter/material.dart';
import 'package:reefood/model/business.dart';
import 'package:reefood/services/Food/business_db.dart';

class BusinessProvider extends ChangeNotifier {
  List<Business> _businessList = [];

  List<Business> get businessList => _businessList;
  BusinessProvider() {
    fetchList();
  }
  Future<void> fetchList() async {
    try {
      _businessList = await BusinessDB().queryBusiness();
      notifyListeners();
    } catch (error) {
      print("Error fetching business list: $error");
    }
  }

  Business? getBusinessById(String id) {
    return _businessList.firstWhere((business) => business.id == id);
  }
}
