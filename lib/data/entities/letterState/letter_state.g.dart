// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LetterStateAdapter extends TypeAdapter<LetterState> {
  @override
  final int typeId = 10;

  @override
  LetterState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LetterState.valid;
      case 1:
        return LetterState.invalid;
      case 2:
        return LetterState.semivalid;
      case 3:
        return LetterState.empty;
      default:
        return LetterState.valid;
    }
  }

  @override
  void write(BinaryWriter writer, LetterState obj) {
    switch (obj) {
      case LetterState.valid:
        writer.writeByte(0);
        break;
      case LetterState.invalid:
        writer.writeByte(1);
        break;
      case LetterState.semivalid:
        writer.writeByte(2);
        break;
      case LetterState.empty:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LetterStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
