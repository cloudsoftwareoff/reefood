import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reefood/Providers/business.provider.dart';
import 'package:reefood/Providers/food_provider.dart';
import 'package:reefood/Providers/near_food_provider.dart';
import 'package:reefood/components/card_shimmer.dart';
import 'package:reefood/functions/distance.dart';
import 'package:reefood/functions/sharedpref.dart';
import 'package:reefood/model/business.dart';
import 'package:reefood/model/food.dart';
import 'package:reefood/screens/home/widgets/BusinessCard.dart';
import 'package:reefood/screens/home/widgets/NoFood.dart';
import 'package:reefood/screens/home/widgets/appbar.dart';
import 'package:reefood/screens/home/widgets/businessList.dart';
import 'package:reefood/screens/home/widgets/loading_home.dart';
import 'package:reefood/screens/home/widgets/my_drawer.dart';
import 'package:reefood/screens/home/widgets/food_card.dart';
import 'package:reefood/screens/productDetail/food_details.dart';
import 'package:reefood/screens/viewFoodList/see_all.dart';
import 'package:reefood/services/Food/business_db.dart';
import 'package:reefood/services/Food/food_db.dart';
import 'package:reefood/services/location_provider.dart';
import 'package:reefood/constant/colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationProvider locationProvider = LocationProvider();
//   LocationInfo? locationInfo;
  late Future<LocationInfo> locationInfoFuture;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return isLoading
        ? const LoadingHomeScreen()
        : SafeArea(
            child: Scaffold(
              backgroundColor: scheme.background,
              // drawer: MyDrawer(parentContext: context),
              body: FutureBuilder<Position>(
                  future: getSavedLocationFromSharedPreferences(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingHomeScreen();
                    } else {
                      Position mypostion = snapshot.data!;
                      return CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TopAppBar(),
                                SearchBusiness(),
    
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Recommended For You',
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SeeAll(
                                                          myPosition: mypostion,
                                                        )),
                                              );
                                            },
                                            child: Text(
                                              'See All',
                                              style: TextStyle(
                                                color: scheme.primary,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    FoodWidget(
                                        mypostion: mypostion)
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        'Food near you',
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    NearFoodWidget(
                                      mypostion: mypostion,
                                    
                                    )
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Business List',
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'See All',
                                            style: TextStyle(
                                              color: scheme.primary,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                        height: 200, child: BusinessList())
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }),

              bottomNavigationBar:
                  // op.currentOrder != null
                  //     ? const ActiveOrderBottomContainer()
                  //     :
                  const SizedBox(),
            ),
          );
  }

  Column buildCollage(BuildContext context, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NoFood(),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {
              // Navigator.pushNamed(context, FoodDeliveryScreen.routeName);
            },
            child: Container(
              height: height * 0.20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: scheme.primary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: const Stack(
                alignment: Alignment.topLeft,
                children: [
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Image(
                      width: 150,
                      image: NetworkImage(
                          'https://i.pinimg.com/564x/70/0d/f5/700df5b522327cf57c58a26480ceafbd.jpg'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Our Partners',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          'Most selling',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            height: 1,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: height * 0.35,
                  decoration: BoxDecoration(
                    color: scheme.onPrimary,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Positioned(
                        bottom: 5,
                        right: 20,
                        child: Image(
                          width: 100,
                          image: AssetImage('assets/img/view.jpg'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'foodlist',
                              style: TextStyle(
                                color: MyColors.textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Groceries and more',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                height: 1,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: height * 0.25,
                      decoration: BoxDecoration(
                        color: MyColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: Image(
                              fit: BoxFit.fill,
                              //width: 100,
                              image: NetworkImage(
                                  'https://i.pinimg.com/564x/e6/80/32/e6803216f6ebbb31ce03485d977b9d54.jpg'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pick-up',
                                  style: TextStyle(
                                    color: MyColors.textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Up to 50% off',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      height: height * 0.10,
                      decoration: BoxDecoration(
                        color: MyColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: const Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Positioned(
                            bottom: 5,
                            right: 0,
                            child: Image(
                              width: 55,
                              image: AssetImage('assets/img/view.jpg'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'reefoood',
                                  style: TextStyle(
                                    color: MyColors.textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Express\nDelivery',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class FoodWidget extends StatelessWidget {
  const FoodWidget({
    Key? key,
    required this.mypostion,
   
  }) : super(key: key);



  final Position mypostion;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final foodProvider = Provider.of<FoodProvider>(context);
    final businessProvider = Provider.of<BusinessProvider>(context);
    // ! find solution instead of this sized box
    return SizedBox(
        height: height * 0.22,
        child: Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: foodProvider.foodList.length,
            itemBuilder: (context, index) {
              final fooditem = foodProvider.foodList[index];
              final business =
                  businessProvider.getBusinessById(fooditem.business_id);
              double distance = calculateDistance(
                business!.latitude,
                business.longitude,
                mypostion.latitude,
                mypostion.longitude,
              );

                return Row(
                  children: [
                    SizedBox(width: index == 0 ? 15 : 0),
                    FoodCard(
                      food: fooditem,
                      user_position: mypostion,
                    
                    ),
                    SizedBox(
                      width:
                          index == foodProvider.foodList.length - 1 ? 15 : 10,
                    ),
                  ],
                );
              
            },
          ),
        ));
  }
}

class NearFoodWidget extends StatelessWidget {
  const NearFoodWidget({
    Key? key,
    required this.mypostion,
  }) : super(key: key);

  final Position mypostion;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final foodProvider = Provider.of<FoodProvider>(context);
    final businessProvider = Provider.of<BusinessProvider>(context);

    // ! find solution instead of this sized box
    return FutureBuilder<List<Business>>(
        future: Provider.of<NearBusinessProvider>(context, listen: false)
            .fetchBusinessNearUser(
          mypostion.latitude,
          mypostion.longitude,
        ),
        builder: (context, snapshot) {
          List<Business>? nearBusiness = snapshot.data;
          if (nearBusiness == null || nearBusiness.isEmpty) {
            return Center(child:
            Text("Sorry no food need saving near you",
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: scheme.secondary
            ),
            ));
          }
          return SizedBox(
              height: height * 0.22,
              child: Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: foodProvider.foodList.length,
                  itemBuilder: (context, index) {
                    final fooditem = foodProvider.foodList[index];
                                            businessProvider.getBusinessById(fooditem.business_id);

                    return Row(
                      children: [
                        SizedBox(width: index == 0 ? 15 : 0),
                        FoodCard(
                          food: fooditem,
                          user_position: mypostion,
                        
                        ),
                        SizedBox(
                          width: index == foodProvider.foodList.length - 1
                              ? 15
                              : 10,
                        ),
                      ],
                    );
                  },
                ),
              ));
        });
  }
}
