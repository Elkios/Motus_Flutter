import 'package:hive/hive.dart';
import "user.dart";
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
  User? user;
  @HiveField(4)
  int? score;
  @HiveField(6)
  List<String>? tries;
  @HiveField(7)
  int? limitTries;

  Game(this.id, this.startDate,this.endDate,this.user,this.score,this.tries,this.limitTries);
}
