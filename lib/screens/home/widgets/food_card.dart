import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/functions/distance.dart';
import 'package:reefood/model/food.dart';
import 'package:reefood/model/business.dart';
import 'package:reefood/model/user_profile.dart';
import 'package:reefood/services/Food/business_db.dart';
import 'package:reefood/services/users/xUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodCard extends StatefulWidget {
  final Position user_position;
  final SaveFood food;
  final bool near;
  const FoodCard(
      {super.key,
      required this.food,
      required this.user_position,
      required this.near});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  bool liked = false;
  List<String> likedFoodIds = [];
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    prefs = await SharedPreferences.getInstance();
    likedFoodIds = prefs.getStringList("likedFoodIds") ?? [];
    // Update the state with the loaded data
    if (mounted) {
      // Check if the widget is still mounted
      setState(() {}); // Call setState() only if the widget is mounted
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Card(
      color: scheme.background,
      elevation: 4,
      child: FutureBuilder<Business>(
          future: BusinessDB().getBusinessById(widget.food.business_id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            } else {
              Business business = snapshot.data!;
              double distance = calculateDistance(
                  business.latitude,
                  business.longitude,
                  widget.user_position.latitude,
                  widget.user_position.longitude);
              if (distance > 20 && widget.near) {
                return const Text('No data available');
              }

              if (likedFoodIds.contains(widget.food.id)) {
                liked = true;
              }

              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: height * 0.22,
                width: width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            fit: BoxFit.cover,
                            height: height * 0.12,
                            width: double.infinity,
                            image: NetworkImage(widget.food.photo),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: scheme.secondary,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    ' ${widget.food.quantity.toStringAsFixed(0)} left',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 10,
                          child: GestureDetector(
                            onTap: () async {
                              String foodId = widget.food.id;
                              final pref =
                                  await SharedPreferences.getInstance();
                              List<String> likedFoodIds =
                                  pref.getStringList("likedFoodIds") ?? [];

                              if (likedFoodIds.contains(foodId)) {
                                likedFoodIds.remove(foodId);
                                setState(() {
                                  liked = false; // Update liked state variable
                                });
                              } else {
                                likedFoodIds.add(foodId);
                                setState(() {
                                  liked = true; // Update liked state variable
                                });
                              }

                              await pref.setStringList(
                                  "likedFoodIds", likedFoodIds);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.grey.shade300,
                                      Colors.grey.shade50
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    color: liked ? scheme.primary : Colors.grey,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                foregroundImage: NetworkImage(business.icon),
                              ),
                              Text(
                                ' ${business.name} ',
                                style: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    const Shadow(
                                      blurRadius: 2.0,
                                      color: Colors.black,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Text(
                            widget.food.title,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Color.fromRGBO(50, 50, 50, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              // fontFamily: boldFont,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 4, 0, 0),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.clock,
                            color: Color.fromARGB(255, 33, 134, 68),
                            size: 15,
                          ),
                          Text(
                            ' 08:00 14:00',
                            style: TextStyle(
                              // color: MyColors.secondaryIconColor,
                              fontSize: 12,
                              // fontFamily: regularFont,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: 3.4,
                                itemCount: 1,
                                itemSize: 19,
                                direction: Axis.horizontal,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.food.reviews.toString(),
                                style: const TextStyle(
                                  color: MyColors.appBarTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Container(
                                height: 10,
                                width: 2,
                                color: Colors.grey,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${distance.toStringAsFixed(1)} Km",
                                style: const TextStyle(
                                  color: MyColors.appBarTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            "${widget.food.price.toString()} TND",
                            style: GoogleFonts.poppins(
                              color: scheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
