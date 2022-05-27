import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motus_flutter/data/entities/game/game.dart';
import 'package:motus_flutter/data/entities/letterState/letter_state.dart';
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

  User? _currentUser;

  Future<void> loadDictionary() async {
    WordRepository repository = await WordRepository.getInstance();
    _list = await repository.loadWords();
  }

  Future<void> loadGame() async {
    UserRepository userRepository = UserRepository.getInstance();
    User? user = userRepository.getCurrentUser();
    if(_currentUser == user) {
      return;
    }
    _game = null;
    _currentUser = user;
    if (_list.isEmpty) await loadDictionary();
    GameRepository gameRepository = await GameRepository.getInstance();

    _game = await gameRepository.findCurrentGameOfUser(user!);
    if (_game == null || _game?.word == null || _game!.isOld()) {
      _game = await createGame();
      _game?.word = getRandomWord();
      _currentInput = _game!.word!.word[0];
      updateGame();
    }
    notifyListeners();
  }

  updateCurrentInput(String input) {
    _currentInput = input;
    notifyListeners();
  }

  addTry() async {
    stdout.writeln('[DEBUG] Check current input : $currentInput');
    if (checkWordExist(currentInput)) {
      tries.add(currentInput);
      Try userTry = checkTry(_game!.word!, currentInput);
      stdout.writeln('[INFO] Try: ${userTry.lettersState}');
      _game!.tries?.add(userTry);
      if (_game!.checkFinished(currentInput)) {
        stdout.writeln(
            '[INFO] Game: ${_game?.id} is finished to ${_game!.checkDefeat() ? 'defeat' : 'victory'} in ${_game!.tries!.length} tries');
        _game!.endDate = DateTime.now();
        stdout.writeln('[INFO] Score: ${_game!.calculateScore()}');
      }
    }
    _currentInput = _game!.word!.word[0];
    updateGame();
    notifyListeners();
  }

  checkWordExist(String word) {
    return _list.any((element) => element.word == word);
  }

  Try checkTry(Word word, String value) {
    List<LetterState> lettersState = [];
    value.split('').reversed.toList().asMap().forEach((index, letter) {
      stdout.writeln('[INFO] Letter: $letter');
      stdout.writeln('[INFO] Word: ${word.word}');
      stdout.writeln('[INFO] Index: $index');
      stdout.writeln('[INFO] Word: ${word.word[value.length - 1 - index]}');
      if (word.word[value.length - 1 - index] == letter) {
        stdout.writeln('[INFO] Letter: $letter is correct');
        stdout.writeln('[INFO] Word: ${word.word[value.length - 1 - index]}');
        lettersState.insert(0, LetterState.valid);
      } else if (word.word.contains(letter)) {
        int countLetterInWord =
            word.word.split('').where((element) => element == letter).length;

        int countLetterInTries = List.generate(index, (index) {
          return value[index] == letter &&
                  [LetterState.valid, LetterState.semivalid]
                      .contains(lettersState[index])
              ? 1
              : 0;
        }).reduce((value, element) => value + element);
        if (countLetterInWord - countLetterInTries > 0) {
          lettersState.insert(0, LetterState.semivalid);
        } else {
          lettersState.insert(0, LetterState.invalid);
        }
      } else {
        lettersState.insert(0, LetterState.invalid);
      }
      stdout.writeln('[INFO] lettersstate : $lettersState');
    });
    // recheck if there is not a duplicate letter in tries
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

  void updateGame() async {
    GameRepository repository = await GameRepository.getInstance();
    await repository.updateGame(_game!);
    return;
  }

  void onKeyboardKeyPressed(String action) {
    if (action == '#ENTER' || action == '#DELETE') {
      if (action == '#ENTER') {
        ///viewModel.checkWord(widget.currentWord);
        if (currentInput.length < game!.word!.wordLength()) {
          // Merge current input with overlay
          updateCurrentInput(game!
              .generateOverlay()
              .asMap()
              .map((index, letter) {
                if (index < currentInput.length) {
                  return MapEntry(index, currentInput[index]);
                }
                return MapEntry(index, letter);
              })
              .values
              .join());
        }
        if (currentInput.length >= game!.word!.wordLength()) {
          addTry();
        }
      } else if (action == '#DELETE') {
        if (currentInput.length > 1) {
          updateCurrentInput(
              currentInput.substring(0, currentInput.length - 1));
        }
      }
    } else {
      if (currentInput.length < game!.word!.wordLength()) {
        updateCurrentInput(currentInput + action);
      }
    }
    stdout.writeln('[INFO] Current input: $currentInput');
  }

  Future<void> logout() async {
    UserRepository repository = UserRepository.getInstance();
    await repository.logout();
  }
}
