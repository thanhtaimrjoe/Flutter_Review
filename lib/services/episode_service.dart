import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yama_shopping/modal/episode.dart';

class EpisodeService {
  Future<List<dynamic>> findEpisodesByCategoryIDAndProductID(
      String categoryID, String productID) async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance
          .collection("yama")
          .doc(categoryID)
          .collection("products")
          .doc(productID)
          .collection("episode")
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
