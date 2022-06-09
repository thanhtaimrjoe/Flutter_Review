import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yama_shopping/models/product.dart';

class ProductService {
  Future<List<dynamic>> findProductsByCategoryID(String categoryID) async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance
          .collection("product")
          .where('categoryID', isEqualTo: categoryID)
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

  Future<List<dynamic>> fetchNewArrivalProducts() async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance
          .collection("product")
          .orderBy('productID', descending: true)
          .limit(15)
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

  Future<List<dynamic>> fetchPopularProducts() async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance
          .collection("product")
          .orderBy('categoryID', descending: true)
          .limit(15)
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
