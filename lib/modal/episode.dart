class Episode {
  final String episodeID;
  final String name;
  final String image;
  final int price;
  final String productID;

  Episode(this.episodeID, this.name, this.image, this.price, this.productID);

  Episode.fromJSON(Map<String, dynamic> parsedJSON)
      : episodeID = parsedJSON['episodeID'],
        name = parsedJSON['name'],
        image = parsedJSON['image'],
        price = parsedJSON['price'],
        productID = parsedJSON['productID'];
}
