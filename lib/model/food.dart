import 'package:cloud_firestore/cloud_firestore.dart';


// surpriseID: Unique identifier.
// storeID: Links the surprise to the offering store.
// title: Title of the surprise.
// description: Detailed description.
// imageURL: Representative image.
// price: Price of the surprise.
// originalPrice: Original price.
// quantityAvailable: Current number of available surprises.
// pickupWindow:
// startTime: Start of the pickup time window.
// endTime: End of the pickup time window.
// dietaryRestrictions: Array of possible restrictions (e.g., ["vegetarian", "gluten-free", "vegan"])
class SaveFood{

  String id;
  String title;
  String desc;
  String business_id;
  String pickup_time;
  Timestamp published_at;
  String photo;
  double quantity;
  double price;
  List<double> reviews = [];

  SaveFood({
  required  this.id,
  required  this.title,
  required  this.desc,
  required  this.business_id,
  required  this.pickup_time,
  required  this.published_at,
  required  this.photo,
  required  this.quantity,
  required  this.price,
  //required  this.reviews,

  }
  );


}