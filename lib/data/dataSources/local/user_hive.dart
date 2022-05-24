import 'package:hive_flutter/hive_flutter.dart';
import '../../entities/user/user.dart';

class UserHive {
  static UserHive? _instance;
  static Box<User>? _box;

  static Future<UserHive> getInstance() async {
    if (_instance == null) {
      _box= await Hive.openBox('User');
      _instance = UserHive._();
    }
    return _instance!;
  }

  UserHive._();

  Future<void> insertUser(User user) async {
    await _box?.add(user);
    await _box?.close();
    return;
  }
}
