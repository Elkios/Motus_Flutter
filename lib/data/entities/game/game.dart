import 'package:hive/hive.dart';
import 'package:motus_flutter/data/entities/try/try.dart';
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

  Game(this.id, this.startDate,this.endDate,this.userId,this.score,this.tries,this.limitTries);

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
    score = limitTries - tries!.length;
    return score;
  }


}
