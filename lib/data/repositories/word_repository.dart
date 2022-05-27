import 'dart:io';

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
  static WordFireStore? _wordFireStore;

  static Future<WordRepository> getInstance() async {
    if (_instance == null) {
      _wordHive = await WordHive.getInstance();
      _instance = WordRepository._();
      _wordFireStore = WordFireStore.getInstance();
    }
    return _instance!;
  }

  WordRepository._();

  Future<Word> insertWord(Word word) async {
    await _wordHive?.insertWord(word);
    return word;
  }

  Future<List<Word>> loadWords() async {
    if(_wordHive!.isEmpty()) {
      String dico = await rootBundle.loadString('assets/files/dico.txt');
      String separator = dico.contains('\r\n') ? '\r\n' : '\n';
      List<String> filteredDico = dico.split(separator).where((word) => word.length >= 5 && word.length <= 9 && !word.contains('-')).toList();
      stdout.writeln('[INFO] ${filteredDico.length} words loaded');
      filteredDico.asMap().forEach((index, text) {
        insertWord(Word(index, removeDiacritics(text.toUpperCase())));
      });
    }
    return _wordHive!.getAllWords();
  }

  bool isEmpty() {
    return _wordHive!.isEmpty();
  }

  // Firestore

  // get all words
  Future<List<Word>> getAllWordsFirebase() async {
    QuerySnapshot<Word> words = await _wordFireStore!.getAll();
    return words.docs.map((doc) => doc.data()).toList();
  }

  // add word
  Future<void> insertWordFirebase(Word word) async {
    await _wordFireStore!.insertWord(word);
  }

  // search word
  Future<List<Word>> searchWordsFirebase(String word) async {
    QuerySnapshot<Word> words = await _wordFireStore!.searchWords(word);
    return words.docs.map((doc) => doc.data()).toList();
  }

  // delete word
  Future<void> deleteWordFirebase(String id) async {
    await _wordFireStore!.deleteWord(id);
  }

  // update word
  Future<void> insertWordWithId(Word word, String id) async {
    await _wordFireStore!.insertWordWithId(word, id);
  }
}