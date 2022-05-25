import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/data/repositories/word_repository.dart';

class MyHomeViewModel with ChangeNotifier {

  late Word _word;
  Word get word => _word;

  late List<Word> _list = [];
  List<Word> get list => _list;

  Future<void> loadDictionary() async {
    WordRepository repository = await WordRepository.getInstance();
    _list = await repository.loadWords();
    _word = getRandomWord();
    notifyListeners();
  }

  // Get random word from dictionary
  Word getRandomWord() {
    return _list[Random().nextInt(_list.length)];
  }

}

