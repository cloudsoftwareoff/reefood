import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reefood/colors.dart';

class NoFood extends StatefulWidget {
  const NoFood({super.key});

  @override
  State<NoFood> createState() => _NoFoodState();
}

class _NoFoodState extends State<NoFood> {
  @override
  Widget build(BuildContext context) {
    return Container(
                // width: 411,
                height: 200,
                
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.directions,
                      color: scheme.primary,
                      size: 24,
                    ),
                    Text(
                      'No Food needs savind - for Now!',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                            
                            fontSize: 16,
                          ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(
                        'looks like no food is going to waste in this area. But remember to keep checking because meals are added throught the day!',
                        textAlign: TextAlign.center,
                        
                      ),
                    ),
                  ],
                ),
              );
  }
}