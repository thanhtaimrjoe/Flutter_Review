class Category {
  final String id;
  final String name;
  final String image;
  Category(this.id, this.name, this.image);

  Category.fromJSON(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        image = parsedJson['image'];
}
