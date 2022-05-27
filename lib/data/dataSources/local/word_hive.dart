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
    return;
  }

  Future<void> deleteWord(Word word) async {
    await _box?.delete(word.id);
    return;
  }

  // Get ALl Words
  List<Word> getAllWords() {
    List<Word> words = _box?.values.toList() ?? [];
    return words;
  }

  // Get Word By Id
  Word? getWordById(int id) {
    Word? word = _box?.get(id);
    return word;
  }

  bool isEmpty() {
    return _box!.isEmpty;
  }

  void clear() {
    _box!.clear();
  }

}