import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


import 'package:reefood/colors.dart';
import 'package:reefood/model/shop.dart';

class RestaurantCard extends StatelessWidget {
  final Shop shop;
  const RestaurantCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                  image: NetworkImage(shop.shopImage),
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
                        EdgeInsets.only(top: 7, left: 5, right: 10, bottom: 7),
                    child: Text(
                      ' ${shop.remainingTime} min',
                      style: TextStyle(
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
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xfffffcff),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          foregroundImage: NetworkImage("https://i.pinimg.com/564x/63/32/07/633207abb7de1997ccbdbe5734eba108.jpg"),
                        ),
                        Text(
                          ' ${shop.shopName} ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            // fontFamily: boldFont,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                
                shop.shopDescription,
                maxLines: 1,
                style: const TextStyle(
                  color: Color.fromRGBO(50, 50, 50, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  // fontFamily: boldFont,
                ),
              ),
              
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '\$ • ${shop.shopDescription}',
            style: const TextStyle(
              // color: MyColors.secondaryIconColor,
              fontSize: 12,
              // fontFamily: regularFont,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  RatingBarIndicator(
                    rating: shop.rating,
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
                    shop.rating.toString(),
                    style: const TextStyle(
                     color: MyColors.appBarTextColor,
                      fontSize: 12,
                      fontWeight:FontWeight.bold ,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                //height: 50, // Set the height as needed
                width: 2, // Set the width to control the thickness of the divider
                color: Colors.grey,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              const SizedBox(width: 5),
                  Text(
                    shop.deliveryPrice.toString(),
                    style: const TextStyle(
                     color: MyColors.appBarTextColor,
                      fontSize: 12,
                      fontWeight:FontWeight.bold ,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}