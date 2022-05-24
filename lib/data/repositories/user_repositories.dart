import '../dataSources/locale/user_hive.dart';
import '../entities/user.dart';

class UserRepository {
  static UserRepository? _instance;
  static UserHive? _userHive;

  static Future<UserRepository> getInstance() async {
    if (_instance == null) {
      _userHive = await UserHive.getInstance();
      _instance = UserRepository._();
    }

    return _instance!;
  }

  UserRepository._();

  Future<User> insertUser(User user) async {
    await _userHive?.insertUser(user);
    return user;
  }
}
