import 'package:bebkeler/core/quiz/models.dart';
import 'package:bebkeler/infrastructure/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizRepository {
  final FirebaseFirestore _firebase;
  final AuthService _authService;
  CollectionReference _resultCollection;

  QuizRepository(this._firebase, this._authService) {
    _resultCollection = _firebase.collection('quiz_results');
  }

  static QuizRepository get instance =>
      QuizRepository(FirebaseFirestore.instance, AuthService.instance);

  Future<List<QuizResult>> getTopResults(String collectionPath, {int limit = 50}) async {
    final data = await _resultCollection
        .where('collectionPath', isEqualTo: collectionPath)
        .orderBy('score', descending: true)
        .limit(limit)
        .get();

    return data.docs.map((item) => _jsonToQuizResult(item.data() as Map<String, dynamic>)).toList();
  }

  Future<List<QuizResult>> getCurrentUserResults({int limit = 50}) async {
    final data = await _resultCollection
        .where('userId', isEqualTo: _authService.currentUser.id)
        .limit(limit)
        .get();

    return data.docs.map((item) => _jsonToQuizResult(item.data() as Map<String, dynamic>)).toList();
  }

  Future addResult(QuizResult result) {
    return _resultCollection.add(_quizResultToJson(result, overriderUserId: true));
  }

  QuizResult _jsonToQuizResult(Map<String, Object> json) => QuizResult(
      collectionPath: json['collectionPath'] as String,
      userDisplayName: json['userDisplayName'] as String,
      userId: json['userId'] as String,
      score: json['score'] as int,
      maxScore: json['maxScore'] as int,
      createdAt: (json['createdAt'] as Timestamp).toDate());

  Map<String, Object> _quizResultToJson(QuizResult result, {bool overriderUserId: false}) => {
        'collectionPath': result.collectionPath,
        'userDisplayName': result.userDisplayName,
        'userId': overriderUserId ? _authService.currentUser.id : result.userId,
        'score': result.score,
        'maxScore': result.maxScore,
        'createdAt': FieldValue.serverTimestamp()
      };
}
