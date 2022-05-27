import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/services.dart';
import 'package:motus_flutter/data/dataSources/firestore/word_firstore.dart';
import 'package:motus_flutter/data/dataSources/local/word_hive.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import '../dataSources/firestore/word_firstore.dart';

class WordRepository {
  static WordRepository? _instance;
  static WordHive? _wordHive;
  static WordFireStore? _wordFirestore;

  static Future<WordRepository> getInstance() async {
    if (_instance == null) {
      _wordHive = await WordHive.getInstance();
      _instance = WordRepository._();
      _wordFirestore = WordFireStore.getInstance();
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
        insertWord(Word(index, removeDiacritics(text.toUpperCase())));
      });
    }
    return _wordHive!.getAllWords();
  }

  bool isEmpty() {
    return _wordHive!.isEmpty();
  }

  Future<List<Word>> getAllFromFirstore() async {
  QuerySnapshot<Word> words = await _wordFirestore!.getAll();
  return words.docs.map((e) => e.data()).toList();
  }

}