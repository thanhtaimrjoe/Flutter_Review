import 'dart:convert';

import 'package:http/http.dart';

class Catalog {
  // final List<Item> items = [
  //   Item(1, 'Ederson', 100,
  //       'https://firebasestorage.googleapis.com/v0/b/anservices.appspot.com/o/Icon%2Fmaterial_color.png?alt=media&token=966cf223-0cfd-43b6-b9da-f8323719efaf'),
  //   Item(2, 'Phil Foden', 500,
  //       'https://firebasestorage.googleapis.com/v0/b/anservices.appspot.com/o/Icon%2Fcomplete_color.png?alt=media&token=091234cf-1014-4cc8-adda-33bcc85659b1'),
  //   Item(3, 'Erling Haaland', 700,
  //       'https://firebasestorage.googleapis.com/v0/b/anservices.appspot.com/o/Icon%2Fproblem_color.png?alt=media&token=a2eb72f2-e717-4026-919a-6e5e69b4e062'),
  //   Item(4, 'Bernado Silva', 900,
  //       'https://firebasestorage.googleapis.com/v0/b/anservices.appspot.com/o/Icon%2Finvoice.png?alt=media&token=d7b01df7-043e-45f0-80ba-0107dd8672eb'),
  //   Item(5, 'Ruben Dias', 200,
  //       'https://firebasestorage.googleapis.com/v0/b/anservices.appspot.com/o/Icon%2Frepair.png?alt=media&token=41e0bb4b-c2c3-4f00-8aac-46df1b316a7a'),
  // ];
  List<Item> items = [];

  Future get fetchCategories async {
    try {
      Response response = await get(Uri.parse(
          "https://61bb0f23e943920017784c15.mockapi.io/api/v1/products"));
      List<Item> data = jsonDecode(response.body);
      print(data);
      items = data;
    } catch (e) {
      //return [];
    }
  }
}

class Item {
  final int id;
  final String name;
  final String image;
  Item(this.id, this.name, this.image);
}
