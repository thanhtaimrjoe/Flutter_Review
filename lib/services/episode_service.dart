import 'package:cloud_firestore/cloud_firestore.dart';

class EpisodeService {
  Stream<QuerySnapshot> fetchRealtimeEpisodes(String productID) {
    return FirebaseFirestore.instance
        .collection('episode')
        .where('productID', isEqualTo: productID)
        .snapshots();
  }
}
