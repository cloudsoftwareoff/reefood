import 'package:cloud_firestore/cloud_firestore.dart';

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