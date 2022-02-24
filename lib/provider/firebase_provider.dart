import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// the firebase provider connects to the firebase firestore cloud
class FirestoreProvider {
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> updateDocument(
      DateTime beginningTime, DateTime endingTime, int price, String index) async {
    _firebaseFirestore
        .collection("Locations")
        .doc(DateFormat('dd-MM-yyyy').format(beginningTime))
        .update({
      index: {
        'beginningTime': beginningTime,
        'endingTime': endingTime,
        'price': price
      }
    }).then((value) => null);
  }

  Future<void> setDocument(
      DateTime beginningTime, DateTime endingTime, int price) async {
    _firebaseFirestore
        .collection("Locations")
        .doc(DateFormat('dd-MM-yyyy').format(beginningTime))
        .set({
      '1': {'beginningTime': beginningTime, 'endingTime': endingTime, 'price': price}
    }).then((value) => null);
  }

  //Stream<QuerySnapshot> getLocationsList() {
  //return _firebaseFirestore.collection("Locations").snapshots();
  //}
  Stream<DocumentSnapshot> getDocumentsListStrem(date) {
    return _firebaseFirestore.collection("Locations").doc(date).snapshots();
  }

  Future<DocumentSnapshot> getDocument(date) {
    return _firebaseFirestore.collection("Locations").doc(date).get();
  }
}
