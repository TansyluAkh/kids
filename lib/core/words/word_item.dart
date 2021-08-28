class WordItem {
  final String title;
  final String name;
  final String description;
  final String imageUrl;
  // TODO Ask what is it.
  final String doc;

  WordItem({this.title, this.name, this.description, this.imageUrl, this.doc});

  static WordItem fromMap(Map<String, dynamic> map) {
    return WordItem(
      title: map['tatword'].toString(),
      name: map['category1'].toString() + '_' + map['category2'].toString(),
      description: '',
      imageUrl: map['image_url'].toString(),
      doc: map['word'].toString(),
    );
  }
}
