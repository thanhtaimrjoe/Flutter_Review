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
        result = event.docs.map((category) {
          Product product = Product.fromJSON(category.data());
          product.setDocID(category.id);
          return product;
        }).toList();
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
          .doc(product.docID)
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
