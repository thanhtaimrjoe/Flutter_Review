import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yamabi_admin/modal/product.dart';

class ProductService {
  Stream<QuerySnapshot> fetchRealtimeProducts(String categoryID) {
    return FirebaseFirestore.instance
        .collection('product')
        .where('categoryID', isEqualTo: categoryID)
        .snapshots();
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
