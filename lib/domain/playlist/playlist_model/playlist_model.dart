import 'package:hive_flutter/hive_flutter.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 2)
class AudioPlayListModel extends HiveObject {
  @HiveField(0)
  final String playlistName;
  @HiveField(1)
  final List<int> playListSongs;

  AudioPlayListModel({required this.playlistName,required this.playListSongs});
}

