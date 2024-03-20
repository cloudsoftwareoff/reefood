import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/functions/sharedpref.dart';
import 'package:reefood/model/food.dart';
import 'package:reefood/screens/home/widgets/food_card.dart';
import 'package:reefood/screens/home/widgets/loading_home.dart';
import 'package:reefood/services/Food/food_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserFavorite extends StatefulWidget {
  const UserFavorite({Key? key}) : super(key: key);

  @override
  State<UserFavorite> createState() => _UserFavoriteState();
}

class _UserFavoriteState extends State<UserFavorite> {
  late SharedPreferences prefs;
  List<String> likedFoodIds = [];
  List<SaveFood> foodlist = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    prefs = await SharedPreferences.getInstance();
    likedFoodIds = prefs.getStringList("likedFoodIds") ?? [];
    foodlist = await FoodDB().queryFood();

    setState(() {});
  }

  SaveFood? findFoodById(String id) {
    try {
      return foodlist.firstWhere((food) => food.id == id);
    } catch (e) {
      print('Food with id $id not found.');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<Position>(
        future: getSavedLocationFromSharedPreferences(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingHomeScreen();
          } else if (snapshot.hasData) {
            Position myPosition = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Favorites',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    itemCount: likedFoodIds.length,
                    itemBuilder: (context, index) {
                      SaveFood? food = findFoodById(likedFoodIds[index]);
                      if (food != null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: FoodCard(
                                  food: food,
                                  user_position: myPosition,
                                  near: false,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        // Handle case when food is not found
                        return SizedBox();
                      }
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }
}
