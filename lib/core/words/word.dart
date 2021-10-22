class Word {
  final String word;
  final String definition;
  final String sentence;
  final String answer;
  final String category;
  final String subCategory;
  final String imageName;
  final String imageUrl;
  final String tatarWord;
  final String tatarCategory;
  final String tatarAudio;
  final String russianAudio;

  String get collectionPath => category + '_' + subCategory;

  Word(
      {required this.word,
      required this.definition,
      required this.sentence,
      required this.answer,
      required this.category,
      required this.subCategory,
      required this.imageName,
      required this.imageUrl,
      required this.tatarWord,
      required this.tatarCategory,
      required this.tatarAudio,
      required this.russianAudio});

  static Word fromMap(Map<String, dynamic> map) {
    return Word(
      word: map['word'].toString(),
      definition: map['definition'].toString(),
      sentence: map['sentence'].toString(),
      answer: map['answer'].toString(),
      category: map['category1'].toString(),
      subCategory: map['category2'].toString(),
      imageName: map['image'].toString(),
      imageUrl: map['image_url'].toString(),
      tatarWord: map['tatword'].toString(),
      tatarCategory: map['tatcategory'].toString(),
      tatarAudio: map['audio1'].toString(),
      russianAudio: map['audio2'].toString(),
    );
  }
}
