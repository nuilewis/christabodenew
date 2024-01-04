// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devotional_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DevotionalAdapter extends TypeAdapter<Devotional> {
  @override
  final int typeId = 0;

  @override
  Devotional read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Devotional(
      title: fields[0] as String,
      scripture: fields[1] as String,
      scriptureReference: fields[2] as String,
      confessionOfFaith: fields[4] as String,
      author: fields[5] as String,
      content: fields[3] as String,
      startDate: fields[6] as DateTime,
      endDate: fields[7] as DateTime?,
      isLiked: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Devotional obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.scripture)
      ..writeByte(2)
      ..write(obj.scriptureReference)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.confessionOfFaith)
      ..writeByte(5)
      ..write(obj.author)
      ..writeByte(6)
      ..write(obj.startDate)
      ..writeByte(7)
      ..write(obj.endDate)
      ..writeByte(8)
      ..write(obj.isLiked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DevotionalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
