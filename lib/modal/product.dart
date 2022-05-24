class Product {
  final String categoryID;
  final String name;
  final int price;
  final String image;
  Product(this.categoryID, this.name, this.price, this.image);

  Product.fromJSON(Map<String, dynamic> parsedJson)
      : categoryID = parsedJson['categoryID'],
        name = parsedJson['name'],
        price = parsedJson['price'],
        image = parsedJson['image'];
}
