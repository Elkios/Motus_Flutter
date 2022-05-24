import 'package:motus_flutter/data/entities/word/word.dart';
import 'package:motus_flutter/data/entities/word/word.dart';

import 'package:hive/hive.dart';

class TrashHive {
  static TrashHive? _instance;
  static Box<Word>? _box;

  static Future<TrashHive> getInstance() async {
    if (_instance == null) {
      _box = await Hive.openBox('Trash');
      _instance = TrashHive._();

    }
    return _instance!;
  }

  TrashHive._();
}