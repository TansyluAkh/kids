import 'package:bebkeler/core/words/word.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WordRepository {
  final FirebaseFirestore _firebase;

  WordRepository(this._firebase);

  static WordRepository get instance => WordRepository(FirebaseFirestore.instance);

  Future<List<Word>> getWord(String name) async {
    print(name);
    CollectionReference categories = _firebase.collection(name);
    QuerySnapshot querySnapshot = await categories.get();
    List<Word> arr = [];
    final allData = querySnapshot.docs.forEach((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      print(data);
      Word word = Word.fromMap(data);
      print(word);
      arr.add(word);
    });
    return arr;
  }
}
