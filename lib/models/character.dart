class Character {
  final String productID;
  final String name;
  final String image;
  Character(this.productID, this.name, this.image);

  Character.fromJSON(Map<String, dynamic> parsedJson)
      : productID = parsedJson['productID'],
        name = parsedJson['name'],
        image = parsedJson['image'];
}
