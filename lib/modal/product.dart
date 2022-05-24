class Product {
  final String categoryID;
  final String name;
  final String image;
  final String productID;
  Product(this.categoryID, this.name, this.image, this.productID);

  Product.fromJSON(Map<String, dynamic> parsedJson)
      : categoryID = parsedJson['categoryID'],
        name = parsedJson['name'],
        image = parsedJson['image'],
        productID = parsedJson['productID'];
}
