
import 'package:hive/hive.dart';
import 'package:motus_flutter/data/entities/letterState/letter_state.dart';

part 'try.g.dart';

@HiveType(typeId: 5)
class Try {
  @HiveField(0)
  final String? _id;
  get id => _id;

  @HiveField(1)
  final String _word;
  String get word => _word;

  @HiveField(2)
  final List<LetterState> _lettersState;
  List<LetterState> get lettersState => _lettersState;


  Try(this._id, this._word, this._lettersState);

}