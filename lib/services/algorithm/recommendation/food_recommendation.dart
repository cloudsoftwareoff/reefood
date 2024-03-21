

import 'package:reefood/model/food.dart';
import 'package:reefood/services/Food/food_db.dart';

Future<List<SaveFood>> recommendedFood()async{
return  FoodDB().queryFood();
}