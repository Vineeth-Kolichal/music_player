import 'package:hive_flutter/hive_flutter.dart';

class AudioPlayListModel extends HiveObject {
  final int? id;
  final String playlistName;
  final int? songCount;

  AudioPlayListModel({required this.playlistName, this.songCount, this.id});

  factory AudioPlayListModel.fromMap(Map<String, dynamic> map) {
    return AudioPlayListModel(
        id: map['id'], playlistName: map['name'], songCount: map['count']);
  }
}
