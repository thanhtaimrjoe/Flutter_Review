import 'dart:convert';
import 'package:http/http.dart';
import 'package:yama_shopping/modal/product.dart';

class ProductService {
  Future<Product> fetchProducts(String id) async {
    Response response = await get(Uri.parse(
        "https://61bb0f23e943920017784c15.mockapi.io/api/v1/products/$id"));
    var jsonResponse = jsonDecode(response.body);
    return Product.fromJSON(jsonResponse);
  }
}
