class Category {
  final String title;
  final String name;
  final String description;
  final String imageUrl;

  Category({required this.title, required this.name, required this.description, required this.imageUrl});

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
        title: map['tat'].toString(),
        name: map['name'].toString(),
        description: map['desc'].toString() != "NaN" ? map['desc'].toString(): ' ',
        imageUrl: map['image'].toString(),
       );
  }
}

