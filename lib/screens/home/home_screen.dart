import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reefood/functions/sharedpref.dart';
import 'package:reefood/model/food.dart';
import 'package:reefood/screens/home/widgets/NoFood.dart';
import 'package:reefood/screens/home/widgets/appbar.dart';
import 'package:reefood/screens/home/widgets/loading_home.dart';
import 'package:reefood/screens/home/widgets/my_drawer.dart';
import 'package:reefood/screens/home/widgets/food_card.dart';
import 'package:reefood/screens/produtDetail/food_details.dart';
import 'package:reefood/services/Food/food_db.dart';
import 'package:reefood/services/location_provider.dart';
import 'package:reefood/colors.dart';


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
bool isLoading=false;

  @override
  void initState() {
    super.initState();
    
    getLocationInfo();
    
  }

  

  Future<LocationInfo> getLocationInfo() async {
    bool hasPermission = await locationProvider.handleLocationPermission(context);
    
    try {
    
      return await locationProvider.getLocation();
      
    } catch (e) {
      print("Error getting location: $e");
      return LocationInfo(isCurrentLocation: false, city: "Error getting location",
      gov: "Error getting location");
    
    }
  
  }
 //final LocationInfo? locationInfo = await locationProvider.getLocation();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;


    return isLoading
        ? const LoadingHomeScreen()
        : SafeArea(
          child: Scaffold(
            backgroundColor:Colors.grey[300],
              drawer: MyDrawer(parentContext: context),
              body: FutureBuilder<Position>(
                future: getSavedLocationFromSharedPreferences(),
                  builder:(context,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingHomeScreen();
                  }
                  else{
                    Position mypostion = snapshot.data!;
                    return
                    CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                      
                    
                 
                    MyAppBar(
                         title: FutureBuilder<LocationInfo>(
                          future: getLocationInfo(),
                          builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return   Text('Loading...');
                } else if (snapshot.hasError) {
                  return Text('Error');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('Unknown');
                } else {
                  LocationInfo locationInfo = snapshot.data!;
                
                  return Text(
                    locationInfo.isCurrentLocation
                        ? "${locationInfo.city} ${locationInfo.gov}"
                        : locationInfo.city.isNotEmpty
                            ? "${locationInfo.city} ${locationInfo.gov}"
                            : 'Unknown City',
                  );
                }
                          },
                        ),
                
                        subtitle: 
                      FutureBuilder<LocationInfo>(
                          future: getLocationInfo(),
                          builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Text('Loading...');
                } else if (snapshot.hasError) {
                  return Text('Error');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('Unknown');
                } else {
                      
                  LocationInfo locationInfo = snapshot.data!;
                  return Text("Within 10km"
                    // locationInfo.isCurrentLocation
                    //     ? locationInfo.gov
                    //     : locationInfo.gov.isNotEmpty
                    //         ? locationInfo.gov
                    //         : 'Unknown Gov',
                  );
                }
                          },
                        ),
                 // Add your logic for province here
                      
                      
                       onTap: () async {
                        // List<Address> addressList =
                        //     await AddressController().fetchAddressArray();
                        // addressList.removeWhere((element) {
                        //   return element.id == lp.address!.id;
                        // });
                        // showSelectAddressModal(context, addressList);
                      },
                      leadingIcon: Builder(builder: (context) {
                        return IconButton(
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ),
                    
                SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            color: Colors.grey[300],
                            child: buildCollage(context, height),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  'Food near you',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                      SizedBox(
                        height: height * 0.3,
                child: FutureBuilder<List<SaveFood>>(
                future: FoodDB().queryFood(),
                builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // While the data is being fetched, show a loading indicator
                          return Foodshimmer();
                        } else if (snapshot.hasError) {
                          // If there's an error, display an error message
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          // If there's no data or the data is empty, you can display a message
                          return Text('No data available');
                        } else {
                          // If data is successfully fetched, display your ListView.builder
                          List<SaveFood> foodlist = snapshot.data!;
                      
                          return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: foodlist.length,
                itemBuilder: (context, index) {
                  final fooditem = foodlist[index];
                      
                  return Row(
                    children: [
                      SizedBox(width: index == 0 ? 15 : 0),
                      GestureDetector(
                         onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => 
        FoodDetailsScreen(food: fooditem,user_position: mypostion,),
      ),
    ),
                        child: FoodCard(food: fooditem,user_position: mypostion,),
                      ),
                      SizedBox(
                        width: index == foodlist.length - 1 ? 15 : 10,
                      ),
                    ],
                  );
                },
                          );
                        }
                },
                          ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                  
                );
  }}),
              
              
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
                      image: AssetImage('assets/img/view.jpg'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Food delivery',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          'Order food you love',
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
                    color:scheme.onPrimary,
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