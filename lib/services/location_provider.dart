import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationProvider {
  Future<bool> handleLocationPermission( BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;
  
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {   
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}
  Future<LocationInfo> getLocation() async {
    try {
      
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        saveLocationToSharedPreferences(position.latitude, position.longitude);
        String address = " ${placemark.locality}";
        String govs ="${placemark.administrativeArea}";

        return LocationInfo(
          isCurrentLocation: true,
          city: address,
          gov: govs
        );
      } else {
        return LocationInfo(
          isCurrentLocation: true,
          city: "Unknown City",
          gov: "Unknown administrativeArea"
        );
      }
    } catch (e) {
      print("Error getting location: $e");
      return LocationInfo(isCurrentLocation: false, city: "Please Enable GPS",
      gov: "Please Enable GPS"
      );
    }
  }
}
void saveLocationToSharedPreferences(double latitude, double longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('latitude', latitude);
    prefs.setDouble('longitude', longitude);
  }


class LocationInfo {
  final bool isCurrentLocation;
  final String city;
  final String gov;

  LocationInfo({required this.isCurrentLocation, required this.city ,required this.gov});
}
