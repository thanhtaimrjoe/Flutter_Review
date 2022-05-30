class Product {
  final String categoryID;
  final String name;
  final String image;
  final String overview;
  final String productID;

  Product(
      this.categoryID, this.name, this.image, this.overview, this.productID);

  Product.fromJSON(Map<String, dynamic> parsedJSON)
      : categoryID = parsedJSON['categoryID'],
        name = parsedJSON['name'],
        image = parsedJSON['image'],
        overview = parsedJSON['overview'],
        productID = parsedJSON['productID'];
}
