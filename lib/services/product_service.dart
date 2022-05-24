import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yama_shopping/modal/product.dart';

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

  Future<List<dynamic>> fetchPopular() async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance
          .collection("popular")
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

  Future<List<dynamic>> fetchNewArrival() async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance
          .collection("new_arrival")
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
