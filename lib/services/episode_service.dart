import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yama_shopping/models/episode.dart';

class EpisodeService {
  Future<List<dynamic>> findEpisodesByProductID(String productID) async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance
          .collection("episode")
          .where('productID', isEqualTo: productID)
          .get()
          .then((event) {
        result = event.docs
            .map((product) => Episode.fromJSON(product.data()))
            .toList();
      });
      return result;
    } catch (e) {
      return [];
    }
  }
}
