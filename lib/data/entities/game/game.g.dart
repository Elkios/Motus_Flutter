// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameAdapter extends TypeAdapter<Game> {
  @override
  final int typeId = 4;

  @override
  Game read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Game(
      fields[0] as int?,
      fields[1] as DateTime?,
      fields[2] as DateTime?,
      fields[3] as User?,
      fields[4] as int?,
      (fields[6] as List?)?.cast<String>(),
      fields[7] as int?,
    )..word = fields[5] as Word?;
  }

  @override
  void write(BinaryWriter writer, Game obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startDate)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.user)
      ..writeByte(4)
      ..write(obj.score)
      ..writeByte(5)
      ..write(obj.word)
      ..writeByte(6)
      ..write(obj.tries)
      ..writeByte(7)
      ..write(obj.limitTries);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
