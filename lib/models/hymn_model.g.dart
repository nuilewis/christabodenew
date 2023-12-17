// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HymnAdapter extends TypeAdapter<Hymn> {
  @override
  final int typeId = 0;

  @override
  Hymn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hymn(
      title: fields[0] as String,
      content: fields[1] as String,
      number: fields[2] as int,
      isLiked: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Hymn obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.isLiked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HymnAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
