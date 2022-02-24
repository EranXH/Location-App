import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_app/model/location_model.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';


import '../../repository/location_repository.dart';

// the BLOC
class LocationsBloc {
  final _repository = LocationRepository();
  final _stringSelectedDate = BehaviorSubject<String>.seeded(DateFormat('dd-MM-yyyy').format(DateTime.now()));

  get stringSelectedDate => _stringSelectedDate.stream;
  Function(String) get changeSelectedDate  => _stringSelectedDate.sink.add;

  // the Stream of DocumentSnapshot 
  Stream<DocumentSnapshot> getDocumentsListStrem(String date) {
    return _repository.getDocumentsListStrem(date);
  }

  //dispose all open sink
  void dispose() async {
    await _stringSelectedDate.drain();
    _stringSelectedDate.close();
  }

  //Convert map to locations list
  List mapToList({List<DocumentSnapshot>? docList}) {
    if (docList != null) {
      List<Location> locationsList = [];
      for (var document in docList) {
        DateTime beginningTime = document.get('beginningTime'); //StringConstant.beginningTime];
        DateTime endingTime = document.get('endingTime'); 
        int price = document.get('price'); 
        locationsList.add(Location(beginningTime: beginningTime, endingTime: endingTime, price:price));
      }
      return locationsList;
    } 

    else {
      return [Location(beginningTime: DateTime(2017, 9, 7, 17, 30), endingTime: DateTime(2017, 9, 7, 17, 30), price: 5)];
    }
  }
}
