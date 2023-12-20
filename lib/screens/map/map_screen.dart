// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
// import 'package:geolocator/geolocator.dart';

// class MapScreen extends StatelessWidget {
//   final double destinationLatitude;
//   final double destinationLongitude;

//   const MapScreen({
//     Key? key,
//     required this.destinationLatitude,
//     required this.destinationLongitude,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map Route'),
//       ),
//       body: FlutterMap(
//         options: MapOptions(
//           center: LatLng(destinationLatitude, destinationLongitude),
//           zoom: 13.0,
//         ),
//         layers: [
//           TileLayerOptions(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: ['a', 'b', 'c'],
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           startNavigation(context);
//         },
//         child: Icon(Icons.navigation),
//       ),
//     );
//   }

//   void startNavigation(BuildContext context) async {
//     FlutterMapboxNavigation _directions = FlutterMapboxNavigation(
//       onRouteProgress: (arrived) {
//         // Handle route progress
//       },
//     );

//     // Get user's current location
//     Position userPosition = await Geolocator.getCurrentPosition();

//     _directions.startNavigation(
//       wayPoints: <WayPoint>[
//         WayPoint(
//           name: "Current Location",
//           latitude: userPosition.latitude,
//           longitude: userPosition.longitude,
//         ),
//         WayPoint(
//           name: "Destination",
//           latitude: destinationLatitude,
//           longitude: destinationLongitude,
//         ),
//       ],
//       mode: MapBoxNavigationMode.drivingWithTraffic,
//       simulateRoute: false,
//       language: "en",
//     );
//   }
// }
