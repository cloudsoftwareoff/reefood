
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:reefood/colors.dart';


class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  double _sliderValue = 5.0;
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
          Container(
            width: 401,
            height: 45,
            decoration:const  BoxDecoration(
              
            ),
            alignment: Alignment.center,
            child:   Center(
              child:  Text(
          "Choose a location \n to see what's available",
          maxLines: 2,
          textAlign: TextAlign.center, // Center the text
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            
          ),
              ),
            )
          ),
          
Stack(
        children: [
          
        ],
      ),
    

          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Select a distance',
              style: GoogleFonts.poppins(fontSize: 16,
              fontWeight: FontWeight.bold,),

            ),
          ),
          
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Slider(
                        value: _sliderValue,
                        onChanged: (newValue) {
                          setState(() {
                            _sliderValue = newValue;
                          });
                        },
                        min: 0,
                        max: 50,
                      ),
                      Text('${_sliderValue.toStringAsFixed(0)} Km' ,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold,
                      
                      fontSize: 12
                        ),
                      ),
                    ],
                  ),
         Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.search),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    )
              ,
            Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.navigation_rounded,
                color: scheme.primary, // Replace with your desired color
                size: 24,
              ),
              Text(
                'use my current location',
                
                style: GoogleFonts.poppins(
                  color: scheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  style: ElevatedButton.styleFrom(
                    primary:scheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child:  Text('Button',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),]
          ),
          ],
              ),
        ),
      ),
    );

  }
}