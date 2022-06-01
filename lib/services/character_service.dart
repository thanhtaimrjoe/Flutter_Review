import 'package:cloud_firestore/cloud_firestore.dart';

class CharacterService {
  Stream<QuerySnapshot> fetchRealtimeCharacters(String productID) {
    return FirebaseFirestore.instance
        .collection('character')
        .where('productID', isEqualTo: productID)
        .snapshots();
  }
}
