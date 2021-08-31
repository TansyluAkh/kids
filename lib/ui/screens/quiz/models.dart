import 'package:flutter/foundation.dart';

class Quiz {
  final String title;
  final List<Question> questions;

  Quiz({
    @required this.title,
    @required this.questions,
  });
}

class Question {
  final String text;
  final List<Option> options;

  Question({
    @required this.text,
    @required this.options,
  });
}

class Option {
  final String text;
  final String imageUrl;
  final bool isCorrect;

  Option({
    this.text,
    this.imageUrl,
    this.isCorrect = false,
  });
}

class UserAnswer {
  final int questionIndex;
  final int chosenOptionIndex;

  UserAnswer(this.questionIndex, this.chosenOptionIndex);
}
