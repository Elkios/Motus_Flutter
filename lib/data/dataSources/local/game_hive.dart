import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../entities/game/game.dart';

class GameHive {
  static GameHive? _instance;
  static Box<Game>? _box;

  static Future<GameHive> getInstance() async {
    if (_instance == null) {
      _box= await Hive.openBox('Game');
      _instance = GameHive._();
    }
    return _instance!;
  }

  GameHive._();

  Future<void> insertGame(Game game) async {
    await _box?.add(game);
    return;
  }

  // update game
  Future<void> updateGame(Game game) async {
    await _box?.putAt(game.id!, game);
    stdout.writeln('[INFO] Game ${game.id!} updated ! - Word : ${game.word!.word}');
    return;
  }

  Future<List<Game>?> findGameByUser(String userid) async {
    return _box?.values.where((game) => game.userId == userid).toList();
  }

  Future<Game?> findCurrentGameOfUser(User user) async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    List<Game>? games = _box?.values.where((game) {
      DateTime dateToCompare = DateTime(game.startDate!.year, game.startDate!.month, game.startDate!.day);
      return game.userId == user.uid && today == dateToCompare;
    }).toList();
    return games!.isNotEmpty ? games.first : null;
  }

  int nextId() {
    return _box!.length;
  }
}
