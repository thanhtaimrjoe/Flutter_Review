import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yamabi_admin/modal/category.dart';

class CategoryService {
  Future<List<dynamic>> fetchCategories() async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance
          .collection("category")
          .get()
          .then((event) {
        result = event.docs
            .map((category) => Category.fromJSON(category.data()))
            .toList();
      });
      return result;
    } catch (e) {
      return [];
    }
  }
}
