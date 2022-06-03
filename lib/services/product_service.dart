import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
        'image': product.image,
        'name': product.name,
        'overview': product.overview,
      });
      return 'Update successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }

  Future<String> addNewProduct(Product product) async {
    try {
      await FirebaseFirestore.instance.collection("product").add({
        'categoryID': product.categoryID,
        'image': product.image,
        'name': product.name,
        'overview': product.overview,
        'productID': product.productID
      });
      return 'Add new product successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }

  Future<String> deleteProduct(String productID, String imageURL) async {
    try {
      await FirebaseFirestore.instance
          .collection("product")
          .where('productID', isEqualTo: productID)
          .get()
          .then((events) => events.docs[0].reference.delete());
      FirebaseStorage.instance.refFromURL(imageURL).delete();
      return 'Delete product successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }
}
