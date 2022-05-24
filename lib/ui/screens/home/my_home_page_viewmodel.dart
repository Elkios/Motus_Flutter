import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/data/repositories/word_repository.dart';

class MyHomeViewModel with ChangeNotifier {

  late Word _word;
  Word get word => _word;

  late List<String> _list = [];
  List<String> get list => _list;

  Future<void> loadDictionary() async {
    String dico = await rootBundle.loadString('assets/files/dico.txt');
    List<String> filteredDico = dico.split('\n').where((word) => word.length >= 5).toList();
    _list = filteredDico;
    notifyListeners();
    return;
  }

}

