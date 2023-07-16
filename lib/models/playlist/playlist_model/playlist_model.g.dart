// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioPlayListModelAdapter extends TypeAdapter<AudioPlayListModel> {
  @override
  final int typeId = 2;

  @override
  AudioPlayListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioPlayListModel(
      playlistName: fields[0] as String,
      playListSongs: (fields[1] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, AudioPlayListModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistName)
      ..writeByte(1)
      ..write(obj.playListSongs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioPlayListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
