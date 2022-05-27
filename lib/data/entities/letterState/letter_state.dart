import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'letter_state.g.dart';

@HiveType(typeId: 10)
enum LetterState {
  @HiveField(0)
  valid,
  @HiveField(1)
  invalid,
  @HiveField(2)
  semivalid,
  @HiveField(3)
  empty
}

extension LetterStateExtension on LetterState {
  Color get color {
    switch (this) {
      case LetterState.valid:
        return Colors.green;
      case LetterState.semivalid:
        return Colors.orange;
      case LetterState.invalid:
        return Colors.transparent;
      case LetterState.empty:
        return Colors.transparent;
      default:
        return Colors.blue;
    }
  }
}