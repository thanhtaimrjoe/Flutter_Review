class Product {
  final String categoryID;
  final String name;
  final String image;
  final String productID;
  final String overview;
  Product(
      this.categoryID, this.name, this.image, this.productID, this.overview);

  Product.fromJSON(Map<String, dynamic> parsedJson)
      : categoryID = parsedJson['categoryID'],
        name = parsedJson['name'],
        image = parsedJson['image'],
        productID = parsedJson['productID'],
        overview = parsedJson['overview'];
}
