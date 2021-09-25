import 'dart:async';
import 'package:bebkeler/core/quiz/models.dart';
import 'package:bebkeler/infrastructure/mvvm/ticker_provider.dart';
import 'package:bebkeler/infrastructure/mvvm/view_model.dart';
import 'package:flutter/material.dart';

const secondsPerQuestion = 25;

class QuizViewModel extends ViewModel with SingleTickerProviderViewModelMixin {
  final Quiz quiz;
  final List<UserAnswer> userAnswers;
  int currentQuestionIndex;

  int secondsLeft;
  AnimationController animationController;
  Animation<double> animation;
  Timer _timer;

  QuizViewModel({@required this.quiz})
      : userAnswers = [],
        secondsLeft = secondsPerQuestion,
        currentQuestionIndex = 0;

  @override
  void init() {
    _timer = Timer.periodic(const Duration(seconds: 1), updateSeconds);
    animationController =
        AnimationController(duration: Duration(seconds: secondsPerQuestion), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    animationController.forward();
  }

  Question get currentQuestion => quiz.questions[currentQuestionIndex];
  bool get isLastStep => currentQuestionIndex == quiz.questions.length - 1;
  bool get isAnswered =>
      userAnswers.indexWhere((el) => el.questionIndex == currentQuestionIndex) != -1;
  UserAnswer get currentAnswer =>
      userAnswers.firstWhere((el) => el.questionIndex == currentQuestionIndex, orElse: () => null);

  void answer(int chosenOptionIndex) {
    if (isAnswered) return;
    userAnswers.add(UserAnswer(currentQuestionIndex, chosenOptionIndex));

    _timer.cancel();
    animationController.stop();

    notifyListeners();
  }

  void goNext() {
    currentQuestionIndex++;

    if (_timer.isActive) _timer.cancel();
    secondsLeft = secondsPerQuestion;
    _timer = Timer.periodic(const Duration(seconds: 1), updateSeconds);
    animationController.reset();
    animationController.forward();

    notifyListeners();
  }

  void updateSeconds(Timer timer) {
    if (secondsLeft <= 1) {
      goNext();
      return;
    }
    secondsLeft--;
  }



  @override
  void dispose() {
    _timer.cancel();
    animationController.dispose();
    super.dispose();
  }
}
