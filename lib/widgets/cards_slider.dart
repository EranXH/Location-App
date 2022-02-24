import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:location_app/model/location_model.dart';

import 'location_card.dart';

// part of the state of the location bloc
// on date change the state is rebulit acording to the given DocumentSnapshot
class CardsSlider extends StatelessWidget {
  final AsyncSnapshot<DocumentSnapshot> snapshot;

  const CardsSlider({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.data?.data().toString() != 'null') {
      // reagenging the given DocumentSnapshot to miningful data (sorting and type setting)
      Map<String, dynamic> snapshotMap =
          snapshot.data!.data() as Map<String, dynamic>;
      var sortedSnapshot = snapshotMap.values.toList();
      sortedSnapshot.sort((a, b) => (a['beginningTime']).compareTo(b['beginningTime']));

      return Expanded(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: sortedSnapshot.length,
            itemBuilder: (context, index) {
              return LocationCard(
                  location: Location.fromJson(sortedSnapshot[index]));
            }),
      );
    } else { // when the given DocumentSnapshot is empty
      return const Text('No Locations');
    }
  }
}
