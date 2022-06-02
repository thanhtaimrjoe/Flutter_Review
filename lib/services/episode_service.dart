import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yamabi_admin/modal/episode.dart';

class EpisodeService {
  Stream<QuerySnapshot> fetchRealtimeEpisodes(String productID) {
    return FirebaseFirestore.instance
        .collection('episode')
        .where('productID', isEqualTo: productID)
        .snapshots();
  }

  Future<String> addNewEpisode(Episode episode, String docID) async {
    try {
      await FirebaseFirestore.instance.collection("episode").doc(docID).set({
        'episodeID': episode.episodeID,
        'image': episode.image,
        'name': episode.name,
        'price': episode.price,
        'productID': episode.productID,
      });
      return 'Add New Episode successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }
}
