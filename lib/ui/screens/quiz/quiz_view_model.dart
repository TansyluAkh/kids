import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models.dart';

final quizViewModelProvider =
    ChangeNotifierProvider.family<QuizViewModel, Quiz>((ref, quiz) => QuizViewModel(quiz: quiz));

class QuizViewModel with ChangeNotifier {
  final Quiz quiz;
  final List<UserAnswer> userAnswers;
  int currentQuestionIndex;

  QuizViewModel({@required this.quiz})
      : userAnswers = [],
        currentQuestionIndex = 0;

  Question get currentQuestion => quiz.questions[currentQuestionIndex];
  bool get isLastStep => currentQuestionIndex == quiz.questions.length - 1;
  bool get isAnswered =>
      userAnswers.indexWhere((el) => el.questionIndex == currentQuestionIndex) != -1;
  UserAnswer get currentAnswer =>
      userAnswers.firstWhere((el) => el.questionIndex == currentQuestionIndex, orElse: () => null);

  void answer(int chosenOptionIndex) {
    if (isAnswered) return;
    userAnswers.add(UserAnswer(currentQuestionIndex, chosenOptionIndex));
    notifyListeners();
  }

  void goNext() {
    currentQuestionIndex++;
    notifyListeners();
  }

  int countCorrectAnswers() {
    var result = 0;
    for (final answer in userAnswers) {
      final userOptionIndex = answer.chosenOptionIndex;
      final correctOptionIndex =
          quiz.questions[answer.questionIndex].options.indexWhere((opt) => opt.isCorrect);

      if (userOptionIndex == correctOptionIndex) result++;
    }

    return result;
  }
}
