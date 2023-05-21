import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

List<Audio> convertToAudioList(List<dynamic> allSongs) {
  List<Audio> allSongAudioList = [];

  for (var x = 0; x < allSongs.length; x++) {
    SongModel song = allSongs[x];
    allSongAudioList.add(
      Audio.file(song.uri!,
          metas: Metas(
            title: song.displayName,
            artist: song.artist,
            id: song.id.toString(),
          )),
    );
  }
  return allSongAudioList;
}
