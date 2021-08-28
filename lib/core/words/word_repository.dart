import 'package:bebkeler/core/words/word.dart';
import 'package:bebkeler/core/words/word_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WordRepository {
  final FirebaseFirestore _firebase;

  WordRepository(this._firebase);

  static WordRepository get instance => WordRepository(FirebaseFirestore.instance);

  Future<Word> getWord(String name, String doc) async {
    CollectionReference categories = _firebase.collection(name);
    DocumentSnapshot element = await categories.doc(doc).get();

    Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    Word word = Word.fromMap(data);

    return word;
  }

  Future<List<WordItem>> getWordItems(String name) async {
    CollectionReference categories = _firebase.collection(name);
    QuerySnapshot querySnapshot =
        await categories.orderBy('word', descending: false).get();

    return querySnapshot.docs
        .map((e) => WordItem.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
