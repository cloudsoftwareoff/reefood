import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reefood/model/food.dart';
import 'package:reefood/screens/home/widgets/food_card.dart';
import 'package:reefood/services/algorithm/recommendation/food_recommendation.dart';

class SeeAll extends StatefulWidget {
  final Position myPosition;
  const SeeAll({super.key, required this.myPosition});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<List<SaveFood>>(
        future: recommendedFood(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          } else if (snapshot.hasData) {
            List<SaveFood>? foodList = snapshot.data;
            if (foodList == null) {
              return Text("Could'nt get food list");
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Recommended for you',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: foodList.length,
                        itemBuilder: (context, index) {
                          SaveFood? food = foodList[index];

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
                                    user_position: widget.myPosition,
                                    
                                  ),
                                ),
                              ),
                            ],
                          );
                        }))
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Text('No data available');
          }
        },
      )),
    );
  }
}
