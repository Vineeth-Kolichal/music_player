import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_player/infrastructure/mixins/audio_mixin.dart';
import 'package:on_audio_query/on_audio_query.dart';


class FetchSongs with AudioMixin{
  factory FetchSongs() {
    return FetchSongs.fetchSongs();
  }
  List<Audio> allSongAudioList = [];
  Future<void> fetchSongs() async {
    OnAudioQuery audioQuery = OnAudioQuery();
    List<SongModel> songs = await audioQuery.querySongs();
    List<SongModel> allSongs = [];
    for (var i = 0; i < songs.length; i++) {
      if (songs[i].fileExtension == 'mp3') {
        allSongs.add(songs[i]);
      }
    }
    allSongAudioList = convertToAudioList(allSongs);
    log('${allSongs.length}');
  }

  FetchSongs.fetchSongs();
}
