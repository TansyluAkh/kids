﻿import 'dart:math';

import 'package:bebkeler/core/word.dart';

class Quiz {
  final String title;
  final String collectionPath;
  final String tatCategory;
  final List<Question> questions;

  Quiz({
    required this.title,
    required this.collectionPath,
    required this.tatCategory,
    required this.questions,
  });

  factory Quiz.fromSubcategory(
      String title, String collectionPath, String tatCategory, List<Word> words) {
    return _createQuiz(title, collectionPath, tatCategory, words);
  }
}

class Question {
  final String text;
  final String definition;
  final String imageUrl;
  final List<Option> options;

  Question({
    required this.text,
    required this.definition,
    required this.imageUrl,
    required this.options,
  });
}

class Option {
  final String text;
  final String? imageUrl;
  final bool isCorrect;

  Option({
    required this.text,
    this.imageUrl,
    this.isCorrect = false,
  });
}

class UserAnswer {
  final int questionIndex;
  final int chosenOptionIndex;

  UserAnswer(this.questionIndex, this.chosenOptionIndex);
}

Quiz _createQuiz(String title, String collectionPath, tatCategory, List<Word> words) {
  words.shuffle();
  final List<Question> questions = [];
  for (int i = 0; i < words.length; i++) {
    questions.add(Question(
        text: words[i].sentence,
        imageUrl: words[i].imageUrl,
        definition: words[i].definition,
        options: _generateOptions(i, words)));
  }

  return Quiz(
      title: title, collectionPath: collectionPath, tatCategory: tatCategory, questions: questions);
}

List<Option> _generateOptions(int correctWordIndex, List<Word> words) {
  final randomInts = _generateInts(0, words.length, 3, excluded: {correctWordIndex});
  final List<Option> result = [];
  for (final index in randomInts) {
    if (words[index].answer == 'null') {
      print(words[index].imageName + ' NULL');
    }
    result.add(Option(
      text: words[index].answer,
    ));
  }
  result.add(Option(text: words[correctWordIndex].answer, isCorrect: true));

  return result..shuffle(Random());
}

// It probably can go infinity loop if all numbers are excluded from range.
// TODO Consider fix this. Or hope for the best.
List<int> _generateInts(int min, int max, int amount, {Set<int>? excluded}) {
  excluded ??= Set();
  final List<int> result = [];
  final random = Random();

  int i = 0;
  while (i < amount) {
    final number = min + random.nextInt(max - min);
    if (excluded.contains(number)) continue;

    result.add(number);
    excluded.add(number);
    i++;
  }

  return result;
}