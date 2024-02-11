import 'package:flutter/material.dart';
import 'package:reefood/model/business.dart';
import 'package:reefood/screens/home/widgets/BusinessCard.dart';
import 'package:reefood/services/Food/business_db.dart';

class BusinessList extends StatefulWidget {
  @override
  _BusinessListState createState() => _BusinessListState();
}

class _BusinessListState extends State<BusinessList> {
  final BusinessDB _businessDB = BusinessDB();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _businessDB.queryFood(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Business>? businesses = snapshot.data;

          return ListView.builder(
            itemCount: businesses?.length,
            itemBuilder: (context, index) {
              return BusinessCard(business: businesses![index]);
            },
          );
        }
      },
    );
  }
}