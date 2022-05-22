import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yama_shopping/modal/product.dart';

class ProductService {
  Future<List<dynamic>> findProductsByCategoryID(String id) async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance
          .collection("yama")
          .doc(id)
          .collection("products")
          .get()
          .then((event) {
        result = event.docs
            .map((product) => Product.fromJSON(product.data()))
            .toList();
      });
      return result;
    } catch (e) {
      return [];
    }
  }
}
