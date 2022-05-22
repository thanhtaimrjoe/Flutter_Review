import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yama_shopping/modal/category.dart';

class CategoryService {
  Future<List<dynamic>> firestoreCategories() async {
    try {
      List<dynamic> result = [];
      await FirebaseFirestore.instance.collection("yama").get().then((event) {
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
