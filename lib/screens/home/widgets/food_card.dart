import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:geolocator/geolocator.dart';
import 'package:reefood/colors.dart';
import 'package:reefood/functions/distance.dart';
import 'package:reefood/model/food.dart';
import 'package:reefood/model/business.dart';

import 'package:reefood/services/Food/business_db.dart';


class FoodCard extends StatelessWidget {
  final Position user_position;
  final SaveFood food;
  const FoodCard({super.key, required this.food, required this.user_position});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Card(
      elevation: 2,
      child: FutureBuilder<Business>(
        future: BusinessDB().getBusinessById(food.business_id),
        builder:(context,snapshot){
          
            if (snapshot.hasError) {
          
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
          
            return const Text('No data available');
          } else {
            Business business = snapshot.data!;
            double distance =calculateDistance(
              business.latitude, business.longitude,
              user_position.latitude, user_position.longitude);
           // Postion businesslocal = getlo
          return SizedBox(
          
          height: height * 0.3,
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
                      height: height * 0.15,
                      width: double.infinity,
                      image: NetworkImage(food.photo),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child:  Padding(
                        padding:
                            const EdgeInsets.only(top: 7, left: 5, right: 10, bottom: 7),
                        child: Text(
                          ' ${food.quantity} left',
                          style:const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: 
          Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              foregroundImage: NetworkImage(business.icon),
                            ),
                            Text(
                              ' ${business.name} ',
                              style: GoogleFonts.poppins(fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,shadows: [
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
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      
                      food.desc,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Color.fromRGBO(50, 50, 50, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        // fontFamily: boldFont,
                      ),
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(height: 6),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.timer,
                    size: 10,),
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
             Row(
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
            food.reviews.toString(),
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
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
          const Spacer(), // Added Spacer widget to push the next widget to the right
          Text(
        "${food.price.toString()} TND",
        style:const TextStyle(
          color: Color.fromARGB(255, 88, 98, 92),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
          ),
        ],
      )
      
            ],
          ),
        );}}
      ),
    );
  }
}