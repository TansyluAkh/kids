class Info {
  final String rusDescription;
  final String tatDescription;
  final String imageUrl;
  final String social;

  Info(
      {required this.tatDescription,
      required this.rusDescription,
      required this.imageUrl,
      required this.social});

  static Info fromMap(Map<String, dynamic> map) {
    return Info(
      social: map['social'].toString(),
      rusDescription: map['rus_desc'].toString(),
      tatDescription: map['tat_desc'].toString(),
      imageUrl: map['image'].toString(),
    );
  }
}
