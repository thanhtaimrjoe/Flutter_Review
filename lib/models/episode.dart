class Episode {
  final String episodeID;
  final String productID;
  final String name;
  final int price;
  final String image;
  Episode(this.episodeID, this.productID, this.name, this.price, this.image);

  Episode.fromJSON(Map<String, dynamic> parsedJson)
      : episodeID = parsedJson['episodeID'],
        productID = parsedJson['productID'],
        name = parsedJson['name'],
        price = parsedJson['price'],
        image = parsedJson['image'];
}
