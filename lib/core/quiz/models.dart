import 'dart:math';

import 'package:bebkeler/core/words/word.dart';
import 'package:flutter/foundation.dart';

class Quiz {
  final String title;
  final String collectionPath;
  final String tatcategory;
  final List<Question> questions;

  Quiz({
    @required this.title,
    @required this.collectionPath,
    @required this.tatcategory,
    @required this.questions,
  });

  factory Quiz.fromSubcategory(
      String title, String collectionPath, String tatcategory, List<Word> words) {
    return _createQuiz(title, collectionPath, tatcategory, words);
  }
}

class Question {
  final String text;
  final String definition;
  final String image;
  final List<Option> options;

  Question({
    @required this.text,
    @required this.definition,
    @required this.image,
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

class QuizResult {
  final String collectionPath;
  final String userId;
  final String userDisplayName;
  final int score;
  final int maxScore;
  DateTime createdAt;

  QuizResult(
      {this.collectionPath,
        this.userId,
        this.userDisplayName,
        this.score,
        this.maxScore,
        this.createdAt});
}

Quiz _createQuiz(String title, String collectionPath, tatcategory, List<Word> words) {
  final List<Question> questions = [];
  for (int i = 0; i < words.length; i++) {
    questions.add(Question(
        text: words[i].sentence,
        image: words[i].imageUrl,
        definition: words[i].definition,
        options: _generateOptions(i, words)));
  }

  return Quiz(
      title: title, collectionPath: collectionPath, tatcategory: tatcategory, questions: questions);
}

// String _hideWord(String word, String sentence) {
//   final regex = RegExp(r'\pL', caseSensitive: false);
//   final matches = regex.allMatches(sentence);
//   for (final match in matches) {
//     final matchedValue = match.group(0);
//     if (!matchedValue.startsWith(word)) continue;
//   }
// }

List<Option> _generateOptions(int correctWordIndex, List<Word> words) {
  final randomInts = _generateInts(0, words.length, 3, excluded: {correctWordIndex});
  final List<Option> result = [];
  for (final index in randomInts) {
    if (words[index].answer == 'null'){
      print(words[index].imageName+ ' NULL');
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
List<int> _generateInts(int min, int max, int amount, {Set<int> excluded}) {
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
