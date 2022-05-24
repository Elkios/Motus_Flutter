import 'package:hive/hive.dart';

part 'word.g.dart';

@HiveType(typeId: 1)
class Word {
  @HiveField(0)
  int? x;
  @HiveField(1)
  int? y;

  Word(this.x, this.y);
}