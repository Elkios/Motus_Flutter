import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/game/game.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/data/repositories/game_repositories.dart';
import 'package:motus_flutter/data/repositories/user_repositories.dart';
import 'package:motus_flutter/data/repositories/word_repository.dart';

class MyHomeViewModel with ChangeNotifier {
  late Word _word;
  Word get word => _word;

  late List<Word> _list = [];
  List<Word> get list => _list;

  late Game _game;
  Game get game => _game;

  Future<void> loadDictionary() async {
    WordRepository repository = await WordRepository.getInstance();
    UserRepository userRepository = UserRepository.getInstance();
    User? user = await userRepository.getCurrentUser();
    _list = await repository.loadWords();
    _word = getRandomWord();
    // repository.insertWordWithId(word, user!.uid);
    print(list);
    notifyListeners();
  }

  Future<void> createGame() async {
    GameRepository repository = await GameRepository.getInstance();
    UserRepository userRepository = UserRepository.getInstance();
    User? user = await userRepository.getCurrentUser();
    if (user != null) {
      _game = await repository.createGame(user);
      notifyListeners();
    }
  }

  Word getRandomWord() {
    return _list[Random().nextInt(_list.length)];
  }

  Future<void> logout() async {
    UserRepository repository = UserRepository.getInstance();
    await repository.logout();
  }
}
