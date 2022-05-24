// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trash.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrashAdapter extends TypeAdapter<Trash> {
  @override
  final int typeId = 3;

  @override
  Trash read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trash(
      (fields[0] as List?)?.cast<Word>(),
    );
  }

  @override
  void write(BinaryWriter writer, Trash obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.words);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrashAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
