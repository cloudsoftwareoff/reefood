import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reefood/constant/colors.dart';

class MarkerData {
  final LatLng location;
  final String name;

  MarkerData(this.location, this.name);
}
// ignore: must_be_immutable
class MapScreen extends StatefulWidget {
  static String id = '/MapScreen';
  double latitude;
  double longitude;
  String label;
  
  MapScreen({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.label,
  }) : super(key: key);


  @override
  _MapScreenState createState() => _MapScreenState();
}
class _MapScreenState extends State<MapScreen> {
  Position? _currentPosition;
  double _currentZoom = 13.0;

  // Add a state variable to store location properties
  String _latitude = "";
  String _longitude = "";
  String _altitude = "";
 List<MarkerData> _markers =[];
  // List of additional marker locations

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  _markers = [
    MarkerData(LatLng(widget.latitude, widget.longitude),widget.label),
    
  ];
  
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case where permissions are still denied (show options to open settings, etc.).
        return;
      }
    }
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Handle the case where services are disabled (suggest enabling, etc.).
        return;
      }

      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Update location properties when position is available
      if (_currentPosition != null) {
        setState(() {
          _latitude = _currentPosition!.latitude.toStringAsFixed(4);
          _longitude = _currentPosition!.longitude.toStringAsFixed(4);
          _altitude = _currentPosition!.altitude.toStringAsFixed(2);
        });
      }
    } catch (e) {
      print(e); // Handle any errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return  FlutterMap(
        options: MapOptions(
          // Use the current position if available, otherwise use a default location
          initialCenter:  LatLng(widget.latitude, widget.longitude) ,
          initialZoom: _currentZoom,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.bustrackerapp',
          ),
          MarkerLayer(
            markers: [
              // Show marker at current position (if available)
              // if (_currentPosition != null)
                Marker(
                  width: 40.0,
                  height: 40.0,
                  point: LatLng(widget.latitude, widget.longitude),
                  child: Icon(Icons.location_pin, color: scheme.primary),
                ),
              // Add additional markers with green color
              for (final markerData in _markers)
                Marker(
                  width: 80.0, // Adjust width and height as needed
                  height: 80.0,
                  point: markerData.location,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          markerData.name,
                          style: TextStyle(fontSize: 12.0, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        color: Colors.yellow,
                        padding: EdgeInsets.all(4.0),
                      ),
                      Icon(
                        Icons.location_on,
                        color: Colors.lightGreen,
                        size: 30.0,
                      ),
                    ],
                  ),
                ),

            ],
          ),
          // ... other map elements (optional)
        ],
      );

    
  }
}