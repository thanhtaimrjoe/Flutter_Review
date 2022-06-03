import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      return 'Add new episode successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }

  Future<int> getEpisodesLength(String productID) {
    return FirebaseFirestore.instance
        .collection('episode')
        .where('productID', isEqualTo: productID)
        .get()
        .then((events) => events.docs.length);
  }

  Future<String> deleteEpisode(String episodeID, String imageURL) async {
    try {
      await FirebaseFirestore.instance
          .collection("episode")
          .where('episodeID', isEqualTo: episodeID)
          .get()
          .then((events) => events.docs[0].reference.delete());
      FirebaseStorage.instance.refFromURL(imageURL).delete();
      return 'Delete episode successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }
}
