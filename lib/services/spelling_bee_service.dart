import 'package:cloud_firestore/cloud_firestore.dart';

class SpellingBeeService {

  //* Generate words based on difficulty
  Future<List> getAudios(String name) async {
    CollectionReference categories = FirebaseFirestore.instance.collection(
        name);
    QuerySnapshot querySnapshot =
    await categories.orderBy('name', descending: false).get();
    List arr = [];
    querySnapshot.docs.forEach((element) {
      arr.add([element['tatword'], element['audio1']]);
    });
    return arr;
  }

  //* Output final list of shuffled words
  List<String> outputWords(List<String> words, int numberOfQuestions) {
    return (words.toList()
      ..shuffle()).sublist(0, numberOfQuestions);
  }
}