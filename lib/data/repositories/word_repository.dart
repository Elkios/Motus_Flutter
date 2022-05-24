import 'package:motus_flutter/data/dataSources/local/word_hive.dart';
import 'package:motus_flutter/data/entities/word/word.dart';

class WordRepository {
  static WordRepository? _instance;
  static WordHive? _wordHive;

  static Future<WordRepository> getInstance() async {
    if (_instance == null) {
      _wordHive = await WordHive.getInstance();
      _instance = WordRepository._();
    }
    return _instance!;
  }

  WordRepository._();

  Future<Word> insertWord(Word word) async {
    await _wordHive?.insertWord(word);
    return word;
  }
}