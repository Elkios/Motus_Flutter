import 'package:firebase_auth/firebase_auth.dart';

import '../dataSources/local/game_hive.dart';
import '../entities/game/game.dart';

class GameRepository {

  static int DEFAULT_TRIES_LIMIT = 5;

  static GameRepository? _instance;
  static GameHive? _gameHive;

  static Future<GameRepository> getInstance() async {
    if (_instance == null) {
      _gameHive = await GameHive.getInstance();
      _instance = GameRepository._();
    }

    return _instance!;
  }

  GameRepository._();

  Future<Game> insertGame(Game game) async {
    await _gameHive?.insertGame(game);
    return game;
  }

  Future<Game> createGame(User user) async {
    return await insertGame(
      Game(
        _gameHive!.nextId(),
        DateTime.now(),
        null,
        user.uid,
        0,
        [],
        DEFAULT_TRIES_LIMIT,
      ),
    );
  }

  // update game
  Future<void> updateGame(Game game) async {
    await _gameHive?.updateGame(game);
    return;
  }

  // Find game by user id
  Future<List<Game>?> findGameByUserId(String userId) async {
    return await _gameHive?.findGameByUser(userId);
  }

  // Find current game of user
  Future<Game?> findCurrentGameOfUser(User user) async {
    return await _gameHive?.findCurrentGameOfUser(user);
  }


}
