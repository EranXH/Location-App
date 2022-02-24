import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_app/provider/firebase_provider.dart';

// the location repository connects between the location bloc the add_form bloc and the firebase provider
class LocationRepository{
  final _firestoreProvider = FirestoreProvider();

  Future<void> updateDocument(DateTime beginningTime, DateTime endingTime, int price, String index) =>
      _firestoreProvider.updateDocument(beginningTime, endingTime, price, index);

  Future<void> setDocument(DateTime beginningTime, DateTime endingTime, int price) =>
      _firestoreProvider.setDocument(beginningTime, endingTime, price);

  Stream<DocumentSnapshot> getDocumentsListStrem(String date) =>
      _firestoreProvider.getDocumentsListStrem(date);

  Future<DocumentSnapshot> getDocument(String date) =>
      _firestoreProvider.getDocument(date);
}
