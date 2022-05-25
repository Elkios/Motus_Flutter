import 'package:diacritic/diacritic.dart';
import 'package:flutter/services.dart';
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

  Future<List<Word>> loadWords() async {
    _wordHive!.clear();
    if(_wordHive!.isEmpty()) {
      String dico = await rootBundle.loadString('assets/files/dico.txt');
      List<String> filteredDico = dico.split('\n').where((word) => word.length >= 5 && word.length <= 9).toList();
      filteredDico.asMap().forEach((index, text) {
        insertWord(Word(index, removeDiacritics(text.toLowerCase())));
      });
    }
    return _wordHive!.getAllWords();
  }
}