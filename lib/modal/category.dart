class Category {
  final String id;
  final String name;
  final String image;

  Category(this.id, this.name, this.image);

  Category.fromJSON(Map<String, dynamic> parsedJSON)
      : id = parsedJSON['id'],
        name = parsedJSON['name'],
        image = parsedJSON['image'];
}
