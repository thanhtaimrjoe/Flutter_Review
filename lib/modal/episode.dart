class Episode {
  final String id;
  final String name;
  final int price;
  final String image;
  Episode(this.id, this.name, this.price, this.image);

  Episode.fromJSON(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        price = parsedJson['price'],
        image = parsedJson['image'];
}
