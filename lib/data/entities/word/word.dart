
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

  int wordLength() => _word?.length ?? 0;

  List<String> toCharsList() => _word?.split('') ?? [];

  Word.fromJson(Map<String, dynamic> json)
      : _id = json['id'] as int,
        _word = json['word'] as String;

  Map<String, dynamic> toJson() => {
    'id': _id,
    'word': _word,
  };
}