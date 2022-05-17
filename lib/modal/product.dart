class Product {
  final String id;
  final List<ProductItem> items;
  Product(this.id, this.items);

  Product.fromJSON(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        items = List<ProductItem>.from(
            parsedJson['items'].map((x) => ProductItem.fromJSON(x)));
}

class ProductItem {
  final String id;
  final String name;
  final int price;
  final String image;
  ProductItem(this.id, this.name, this.price, this.image);

  ProductItem.fromJSON(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        price = parsedJson['price'],
        image = parsedJson['image'];
}
