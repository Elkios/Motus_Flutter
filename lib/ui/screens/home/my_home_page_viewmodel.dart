import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/game/game.dart';
import 'package:motus_flutter/data/entities/try/try.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/data/repositories/game_repositories.dart';
import 'package:motus_flutter/data/repositories/user_repositories.dart';
import 'package:motus_flutter/data/repositories/word_repository.dart';
import 'package:motus_flutter/ui/widgets/game/letter_widget.dart';

class MyHomeViewModel with ChangeNotifier {

  late List<Word> _list = [];
  List<Word> get list => _list;

  Game? _game;
  Game? get game => _game;

  String _currentInput = '';
  String get currentInput => _currentInput;

  final List<String> _tries = [];
  List<String> get tries => _tries;

  Future<void> loadDictionary() async {
    WordRepository repository = await WordRepository.getInstance();
    _list = await repository.loadWords();
    stdout.writeln('[INFO] ${_list.length} words loaded');
  }

  Future<void> loadGame() async {
    if(_list.isEmpty) await loadDictionary();
    if(_game == null) {
      _game = await createGame();
      _game?.word = getRandomWord();
      _currentInput = _game!.word!.word[0];
      stdout.writeln('[INFO] Game: ${_game?.id}');
      stdout.writeln('[INFO] Word: ${_game?.word?.word}');
      notifyListeners();
    }
  }

  updateCurrentInput(String input) {
    _currentInput = input;
    notifyListeners();
  }

  addTry() {
    if(checkWordExist(currentInput)) {
      tries.add(currentInput);
      Try userTry = checkTry(_game!.word!, currentInput);
      stdout.writeln('[INFO] Try: ${userTry.lettersState}');
      _game!.tries?.add(userTry);
      if(_game!.checkFinished(currentInput)) {
        stdout.writeln('[INFO] Game: ${_game?.id} is finished to ${_game!.checkDefeat() ? 'defeat' : 'victory'} in ${_game!.tries!.length} tries');
        _game!.endDate = DateTime.now();
        stdout.writeln('[INFO] Score: ${_game!.calculateScore()}');
      }
    }
    _currentInput = _game!.word!.word[0];
    notifyListeners();
  }

  checkWordExist(String word) {
    return _list.any((element) => element.word == word);
  }

  bool checkVictory(Word word, String input) {
    return word.word == input;
  }

  Try checkTry(Word word, String value) {
    List<LetterState> lettersState = [];
    value.split('').asMap().forEach((index, letter) {
      if(word.word[index] == letter) {
        lettersState.add(LetterState.valid);
      } else if(word.word.contains(letter)) {
        lettersState.add(LetterState.semivalid);
      } else {
        lettersState.add(LetterState.invalid);
      }
    });
    return Try('${game!.id}-${game?.tries?.length}', value, lettersState);
  }

  Future<Game> createGame() async {
    stdout.writeln('[INFO] Creating game...');
    GameRepository repository = await GameRepository.getInstance();
    UserRepository userRepository = UserRepository.getInstance();
    User? user = await userRepository.getCurrentUser();
    return await repository.createGame(user!);
  }

  Word getRandomWord() {
    return _list[Random().nextInt(_list.length)];
  }

  Future<void> logout() async {
    UserRepository repository = UserRepository.getInstance();
    await repository.logout();
  }
}
