
import 'package:cloud_firestore/cloud_firestore.dart';


// Stores (or Businesses)

// storeID: Unique identifier.
// storeName: Name of the store.
// location:
// address: Full street address
// coordinates: Geospatial coordinates (latitude, longitude)
// description: Brief store description.
// imageUrls: Array of image URLs.
// storeTypes: Array of store categories (e.g., ["bakery", "restaurant"])
// contactPhone: Store's phone number.
// website: Store's website (if available).
// averageRating: Average rating.
// numRatings: Total number of ratings.

class Business{

  String id;
  String name;
  String icon;
  String opentime;
  double longitude;
  double latitude;

  Business({
    required this.id,
    required this.name,
    required this.icon,
    required this.opentime,
    required this.longitude,
    required this.latitude
  });
  
}