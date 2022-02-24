import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Location extends Equatable {
  final DateTime beginningTime;
  final DateTime endingTime;
  final int price;

  const Location({
    required this.beginningTime,
    required this.endingTime,
    required this.price,
  });

  @override
  List<Object?> get props => [beginningTime, endingTime, price];

  // constract the model from the jsonMap
  static Location fromJson(Map<String, dynamic> jsonMap) {
    Location location = Location(
        beginningTime: (jsonMap['beginningTime'] as Timestamp).toDate(),
        endingTime: (jsonMap['endingTime'] as Timestamp).toDate(),
        price: jsonMap['price']);

    return location;
  }
}
