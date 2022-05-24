import 'package:hive/hive.dart';
import 'package:motus_flutter/data/entities/word/word.dart';

class WordHive {
  static WordHive? _instance;
  static Box<Word>? _box;

  static Future<WordHive> getInstance() async {
    if (_instance == null) {
      _box = await Hive.openBox('Word');
      _instance = WordHive._();

    }
    return _instance!;
  }

  WordHive._();

  Future<void> insertWord(Word word) async {
    await _box?.add(word);
    //await _box?.close();
    return;
  }
}