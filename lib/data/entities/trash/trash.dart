
import 'package:hive/hive.dart';
import 'package:motus_flutter/data/entities/word/word.dart';

part 'trash.g.dart';

@HiveType(typeId: 3)
class Trash {
  @HiveField(0)
  List<Word>? words;

  Trash(this.words);
}