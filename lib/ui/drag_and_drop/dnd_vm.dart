import 'dart:collection';

import 'package:bebkeler/core/word.dart';
import 'package:bebkeler/infrastructure/mvvm.dart';
import 'package:bebkeler/infrastructure/navigation_service.dart';

enum Match { correct, wrong, none }

class WordMatch {
  final Word word;
  Match match;

  WordMatch(this.word, this.match);
}

class DndViewModel extends ViewModel {
  final List<WordMatch> wordMatches;
  final Queue<Word> words;

  DndViewModel(List<Word> words)
      : wordMatches = words.map((w) => WordMatch(w, Match.none)).toList(),
        words = Queue.of(words);

  Word get currentWord => words.first;

  makeMatch(Word lhs, Word rhs) {
    final pair = wordMatches.firstWhere((w) => w.word.word == lhs.word);

    if (lhs.word == rhs.word) {
      pair.match = Match.correct;
      words.removeFirst();
    } else {
      pair.match = Match.wrong;
    }
    if (words.isEmpty)
      NavigationService.instance.goBack();
    else
      notifyListeners();
  }

  calculateScore() {
    return wordMatches.where((m) => m.match == Match.correct).toList().length;
  }
}
