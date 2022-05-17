import 'dart:convert';
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
}
