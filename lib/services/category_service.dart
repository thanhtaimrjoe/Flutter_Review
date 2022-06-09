import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yama_shopping/models/category.dart';

class CategoryService {
  Future<List<dynamic>> firestoreCategories() async {
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

  Future<String> findCategoryNameByCategoryID(String categoryID) async {
    try {
      String result = '';
      await FirebaseFirestore.instance
          .collection("category")
          .where('id', isEqualTo: categoryID)
          .get()
          .then((event) => {result = event.docs[0].get('name')});
      return result;
    } catch (e) {
      return '';
    }
  }
}
