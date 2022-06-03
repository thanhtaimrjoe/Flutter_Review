import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yamabi_admin/modal/category.dart';

class CategoryService {
  Stream<QuerySnapshot> fetchRealtimeCategories() {
    return FirebaseFirestore.instance.collection('category').snapshots();
  }

  Future<String> addNewCategory(Category category) async {
    try {
      await FirebaseFirestore.instance.collection("category").add({
        'id': category.id,
        'image': category.image,
        'name': category.name,
      });
      return 'Add new category successfully';
    } catch (error) {
      return "Error adding document: $error";
    }
  }
}
