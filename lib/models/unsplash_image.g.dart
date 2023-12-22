// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unsplash_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UnsplashImageAdapter extends TypeAdapter<UnsplashImage> {
  @override
  final int typeId = 6;

  @override
  UnsplashImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UnsplashImage(
      id: fields[0] as String?,
      imgUrl: fields[1] as String,
      blurHash: fields[2] as String,
      uploaderName: fields[4] as String?,
      colour: fields[3] as String?,
      uploaderUrl: fields[5] as String?,
      date: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UnsplashImage obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imgUrl)
      ..writeByte(2)
      ..write(obj.blurHash)
      ..writeByte(3)
      ..write(obj.colour)
      ..writeByte(4)
      ..write(obj.uploaderName)
      ..writeByte(5)
      ..write(obj.uploaderUrl)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnsplashImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
