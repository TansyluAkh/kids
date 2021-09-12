import 'package:bebkeler/core/quiz/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizRepository {
  final FirebaseFirestore _firebase;
  CollectionReference _resultCollection;

  QuizRepository(this._firebase) {
    _resultCollection = _firebase.collection('quiz_results').withConverter<QuizResult>(
        fromFirestore: (snapshot, _) => QuizResult.fromJson(snapshot.data()),
        toFirestore: (quizResult, _) => quizResult.toJson());
  }

  static QuizRepository get instance => QuizRepository(FirebaseFirestore.instance);

  Future addResult(QuizResult result) {
    return _resultCollection.add(result);
  }
}
