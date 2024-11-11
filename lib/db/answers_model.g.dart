// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswersAdapter extends TypeAdapter<Answers> {
  @override
  final int typeId = 3;

  @override
  Answers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Answers(
      id: fields[0] as int,
      studentId: fields[1] as int,
      questionId: fields[2] as int,
      choicesId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Answers obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.studentId)
      ..writeByte(2)
      ..write(obj.questionId)
      ..writeByte(3)
      ..write(obj.choicesId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
