import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:location_app/model/location_model.dart';

// The widget card item below the Calender
class LocationCard extends StatelessWidget {
  final Location location;

  const LocationCard({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // formating values from the inputed location model
    final String beginningTime = DateFormat('HH:mm').format(location.beginningTime);
    final String endingTime = DateFormat('HH:mm').format(location.endingTime);
    final String price = location.price.toString();
    return Padding( //The reterned widget 
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(129, 15, 136, 116),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Center(
                  child: Text(
                "$beginningTime - $endingTime",
                style: const TextStyle(height: 2, fontSize: 28),
              )),
              Center(
                  child: Text(
                '$price\$',
                style: const TextStyle(height: 2.5, fontSize: 20),
              ))
            ],
          ),
        ));
  }
}

