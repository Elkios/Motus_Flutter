import 'package:motus_flutter/data/entities/trash/trash.dart';

import 'package:hive/hive.dart';

class TrashHive {
  static TrashHive? _instance;
  static Box<Trash>? _box;

  static Future<TrashHive> getInstance() async {
    if (_instance == null) {
      _box = await Hive.openBox('Trash');
      _instance = TrashHive._();

    }
    return _instance!;
  }

  TrashHive._();

  Future<void> insertTrash(Trash trash) async {
    await _box?.add(trash);
    await _box?.close();
    return;
  }


}