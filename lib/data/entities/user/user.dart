import 'package:hive/hive.dart';
import '../game/game.dart';
part 'user.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? login;
  @HiveField(2)
  String? password;
  @HiveField(3)
  Game? game;

  User(this.id, this.login,this.password,this.game);
}
