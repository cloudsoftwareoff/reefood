import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reefood/colors.dart';
import 'package:reefood/functions/distance.dart';
import 'package:reefood/model/business.dart';
import 'package:reefood/model/food.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reefood/services/Food/business_db.dart';
import 'package:reefood/services/location_provider.dart';
class FoodDetailsScreen extends StatelessWidget {
  final SaveFood food;
  
  final Position user_position;

  FoodDetailsScreen({Key? key, required this.food,
  
  required this.user_position
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
    
     child: Scaffold(
      backgroundColor: Colors.grey[300],
      body: FutureBuilder<Business>(
        future: BusinessDB().getBusinessById(food.business_id),
        builder: (context,snapshot){
            if (snapshot.hasError) {
          
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
          
            return const Text('No data available');
          } else {
            Business business = snapshot.data!;

          return 
           SingleChildScrollView(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment:const AlignmentDirectional(0, 0),
                      child: Image.network(
                        food.photo,
                        width: double.infinity,
                        height: 170,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment:const AlignmentDirectional(0, 0),
                      child: Padding(
                        padding:const EdgeInsets.all(8),
                        child :  SizedBox(
                        
                          height: 150,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            
                            Expanded(child: 
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.grey.shade300, Colors.grey.shade400],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      color: scheme.primary,
                      size: 50,
                    ),
                  ),
                )

,
                                ClipRRect(
  borderRadius: BorderRadius.circular(20),
  child: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade300, Colors.grey.shade400],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        Icons.favorite_outline,
        color: scheme.primary,
        size: 30,
      ),
    ),
  ),
)

                              ],
                            ),
                            ),
                            const SizedBox(height: 50,),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    business.icon,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const  SizedBox(width: 20,),
                                Text(
                                  business.name,
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
                          ],
                        ),)
                      ),
                    ),
                  ],
                ),
                Padding(padding: 
                const EdgeInsets.all(4)
                ,
                child:
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                        const Icon(
                      Icons.shopping_bag,
                      color: Colors.grey,
                      size: 24,
                    )
                      ,const SizedBox(width: 10,),
                    Text(
                    food.title,
                      style:GoogleFonts.poppins(color: scheme.primary,
                      fontSize: 16),
                         
                    )
                    ],),
                    
                   const Text(
                      '30 TND',
                      style: TextStyle(
                        decoration:TextDecoration.lineThrough
                      ),
                     
                    ),
                  ],
                )),
                Padding(
                  padding:const  EdgeInsets.all(4),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:const  EdgeInsets.all(2),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                                 Icon(
                      Icons.star,
                      color: scheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 10,),
                    const Text('4.6 '),
                    const Text('(345)',
                    style: TextStyle(
                      color: Colors.grey
                    ),)
                            ],),
                            Text(
                              'Price: ${food.price} TND',
                              style:GoogleFonts.poppins(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(children: [
                      const Icon(
                        Icons.timelapse,
                        color: Color(0xFF30BF3E),
                        size: 24,
                      ),const SizedBox(width: 10,),
                      Text("Pick up: ${food.pickup_time}")
                  ],),
                ),
                 Divider(height: 2,
                        color: Colors.grey[500],
                        thickness: 2,),
                Padding(
                  padding: const EdgeInsetsDirectional.all(8),
                
                child:
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_pin,
                      color: Color(0xFF30BF3E),
                      size: 24,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<String?>(
                          future: getLocationfromcords(business.latitude, business.longitude),
                           builder: ((context, snapshot) {
                              if (snapshot.hasError) {
                                return const  Text("no location");
                              }else if (!snapshot.hasData) {
          
            return const Text('No data available');
          } else{
            String? businessLocation = snapshot.data;
            return Text(businessLocation!,
            style: TextStyle(
              color: scheme.primary
            ),
            );
          }
          
                           }))
                        ,
                        const Text(
                          'More information about the store',
                        
                        ),
                         
                      ],
                      
                    ),
                    Icon(
                      Icons.navigate_next,
                      color:  scheme.primary,
                      size: 24,
                    ),
                  ],
                )
                ,),
                Divider(height: 2,
                        color: Colors.grey[500],
                        thickness: 2,),
                 Padding(
                  padding: const  EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: Text(
                    food.desc,
                   
                  ),
                ),
                const Text(
                  'Rating: 4.5',
                  
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    onPressed: () {
                      //print('Button pressed ...');
                    },
                   child:Text( 'Add to Cart',
                    style: TextStyle(
                      
                      height: 50,
                        color:  scheme.primary,
                      
                      
                    ),
                  ),
                  )
                ),
              ],
            ),
         
         
         
          );
          }
        },
        
       
      ),
    )
    );
  }
}
