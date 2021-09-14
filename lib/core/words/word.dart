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
      {this.word,
      this.definition,
      this.sentence,
      this.answer,
      this.category,
      this.subCategory,
      this.imageName,
      this.imageUrl,
      this.tatarWord,
      this.tatarCategory,
      this.tatarAudio,
      this.russianAudio});

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
