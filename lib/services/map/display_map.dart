import 'package:flutter/material.dart';

class DisplayMap extends StatelessWidget {
  final double latitude, longitude;

  const DisplayMap({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    const apiKey = 'pk.b5ea1471e3a7ba600c378a19a5fae785';
    const zoomLevel = 15;
    const mapWidth = 400;
    const mapHeight = 300;

    final mapUrl = 'https://maps.locationiq.com/v3/staticmap?key=$apiKey&center=$latitude,$longitude&size=${mapWidth}x$mapHeight&zoom=$zoomLevel&markers=icon:default-marker|$latitude,$longitude';

    return Center(
      child: Stack(
      children: [
      Image.network(mapUrl),
      Positioned(
        bottom: 50, 
        left: 100,  
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.white,
          child: Text(
            'Address Name', 
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      ],
    ),
    );

  }
}
