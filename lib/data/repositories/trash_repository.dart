import 'package:motus_flutter/data/dataSources/local/Trash_hive.dart';
import 'package:motus_flutter/data/entities/Trash/Trash.dart';

class TrashRepository {
  static TrashRepository? _instance;
  static TrashHive? _TrashHive;

  static Future<TrashRepository> getInstance() async {
    if (_instance == null) {
      _TrashHive = await TrashHive.getInstance();
      _instance = TrashRepository._();
    }
    return _instance!;
  }

  TrashRepository._();
}