import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<Position> getSavedLocationFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double? savedLatitude = prefs.getDouble('latitude');
  double? savedLongitude = prefs.getDouble('longitude');

  if (savedLatitude != null && savedLongitude != null) {
    return Position(
      latitude: savedLatitude,
      longitude: savedLongitude,
      timestamp: DateTime.now(),
      accuracy: 0.0,  
      altitude: 0.0, 
      altitudeAccuracy: 0.0,  
      heading: 0.0, 
      headingAccuracy: 0.0, 
      speed: 0.0,  
      speedAccuracy: 0.0,  
    );
  } else {
    
    return Position(
      latitude: 0.0,
      longitude: 0.0,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      altitudeAccuracy: 0.0,
      heading: 0.0,
      headingAccuracy: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );
  }
}
