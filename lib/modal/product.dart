class Product {
  final String categoryID;
  final String name;
  final String image;
  final String overview;
  final String productID;
  String docID = '';

  Product(this.categoryID, this.name, this.image, this.overview, this.productID,
      this.docID);

  void setDocID(String newDocID) {
    docID = newDocID;
  }

  Product.fromJSON(Map<String, dynamic> parsedJSON)
      : categoryID = parsedJSON['categoryID'],
        name = parsedJSON['name'],
        image = parsedJSON['image'],
        overview = parsedJSON['overview'],
        productID = parsedJSON['productID'];
}
