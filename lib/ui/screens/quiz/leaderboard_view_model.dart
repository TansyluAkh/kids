import 'dart:async';

import 'package:bebkeler/core/quiz/models.dart';
import 'package:bebkeler/core/quiz/quiz_repository.dart';
import 'package:bebkeler/infrastructure/mvvm/view_model.dart';

class QuizLeaderboardViewModel extends ViewModel {
  final QuizRepository _quizRepository;
  final String collectionPath;

  QuizLeaderboardViewModel(this.collectionPath, this._quizRepository);

  List<QuizResult> results = [];

  @override
  Future<void> init() async {
    setLoading(true);
    results = await _quizRepository.getTopResults(collectionPath);
    setLoading(false);
  }
}
