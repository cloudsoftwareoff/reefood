
import 'package:cloud_firestore/cloud_firestore.dart';

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