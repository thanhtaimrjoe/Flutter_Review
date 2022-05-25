class Character {
  final String productID;
  final List<dynamic> items;
  Character(this.productID, this.items);

  Character.fromJSON(Map<String, dynamic> parsedJson)
      : productID = parsedJson['productID'],
        items = parsedJson['items'];
}
