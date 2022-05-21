import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:yama_shopping/modal/category.dart';

class CategoryService {
  Future<List<dynamic>> fetchCategories() async {
    try {
      Response response = await get(Uri.parse(
          "https://61bb0f23e943920017784c15.mockapi.io/api/v1/categories"));
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((category) => Category.fromJSON(category))
          .toList();
    } catch (e) {
      return [];
    }
  }

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
