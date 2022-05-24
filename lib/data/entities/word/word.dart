
import 'package:hive_flutter/hive_flutter.dart';

part 'word.g.dart';

@HiveType(typeId: 1)
class Word {
  @HiveField(0)
  final int? _id;
  get id => _id;

  @HiveField(1)
  final String? _word;
  get word => _word;

  Word(this._id, this._word);

  wordLength() => _word?.length ?? 0;

  toCharsList() => _word?.split('') ?? [];
}