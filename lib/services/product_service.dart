import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yamabi_admin/modal/product.dart';

class ProductService {
  Future<List<dynamic>> fetchProductsByCategoryID(String categoryID) async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance
          .collection("product")
          .where('categoryID', isEqualTo: categoryID)
          .get()
          .then((event) {
        result = event.docs
            .map((category) => Product.fromJSON(category.data()))
            .toList();
      });
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<String> updateProduct(Product product) async {
    try {
      await FirebaseFirestore.instance
          .collection("product")
          .doc('2PO5Wdn5OlLFO1oHpGgj')
          .update({
        'productID': product.productID,
        'name': product.name,
        'overview': product.overview,
      });
      return 'Update successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }
}
