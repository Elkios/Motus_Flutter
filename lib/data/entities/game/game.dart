import 'dart:io';

import 'package:hive/hive.dart';
import 'package:motus_flutter/data/entities/letterState/letter_state.dart';
import 'package:motus_flutter/data/entities/try/try.dart';
import 'package:motus_flutter/ui/widgets/keyboard/keyboard_key_widget.dart';

import '../word/word.dart';

part 'game.g.dart';

@HiveType(typeId: 4)
class Game {
  @HiveField(0)
  int? id;
  @HiveField(1)
  DateTime? startDate;
  @HiveField(2)
  DateTime? endDate;
  @HiveField(3)
  String? userId;
  @HiveField(4)
  int score;
  @HiveField(5)
  Word? word;
  @HiveField(6)
  List<Try>? tries;
  @HiveField(7)
  int limitTries;

  Game(this.id, this.startDate, this.endDate, this.userId, this.score,
      this.tries, this.limitTries);

  bool checkVictory(String input) {
    return word!.word == input;
  }

  bool checkDefeat() {
    return tries!.length >= limitTries;
  }

  bool checkFinished(String input) {
    return checkVictory(input) || checkDefeat();
  }

  bool isFinished() {
    return endDate != null;
  }

  bool isVictory() {
    return endDate != null && score > 0;
  }

  int calculateScore() {
    // calculate score based on tries ( and time )
    score =
        (limitTries - tries!.length) + (checkVictory(tries!.last.word) ? 1 : 0);
    return score;
  }

  List<String> generateOverlay() {
    List<String> overlay = List.generate(word!.wordLength(), (index) => '');
    for (Try tryItem in tries!) {
      for (int i = 0; i < tryItem.lettersState.length; i++) {
        overlay[i] =
            tryItem.lettersState[i] == LetterState.valid ? tryItem.word[i] : '';
      }
    }
    return overlay;
  }

  Map<String, KeyState> getKeyboardOverlay() {
    List<String> alphabet = 'abcdefghijklmnopqrstuvwxyz'.split('');
    Map<String, KeyState> keyboardOverlay = { for (var letter in alphabet) letter : KeyState.unused };
    // for each try if letter valid or semivalid then add to keyboard overlay
    stdout.writeln('[DEBUG] BEFORE keyboard overlay: $keyboardOverlay');
    for (Try tryItem in tries!) {
      for (int i = 0; i < tryItem.lettersState.length; i++) {
        stdout.writeln('[DEBUG] Letter : ${tryItem.word[i]}');
        String letter = tryItem.word[i].toLowerCase();
        if (tryItem.lettersState[i] == LetterState.valid) {
          keyboardOverlay[letter] = KeyState.valid;
        } else if (tryItem.lettersState[i] == LetterState.semivalid) {
          keyboardOverlay[letter] = KeyState.semivalid;
        } else if (tryItem.lettersState[i] == LetterState.invalid) {
          stdout.writeln('[DEBUG] Letter : ${tryItem.word[i]} is invalid');
          keyboardOverlay[letter] = KeyState.invalid;
        }
      }
    }
    stdout.writeln('[DEBUG] AFTER keyboard overlay: $keyboardOverlay');
    return keyboardOverlay;
  }

  bool isOld() {
    return startDate != null &&
        startDate!.difference(DateTime.now()).inDays > 1;
  }
}
