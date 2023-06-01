import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

mixin AudioMixin{
  List<Audio> convertToAudioList(List<SongModel> allSongs) {
  List<Audio> allSongAudioList = [];
  for (var x = 0; x < allSongs.length; x++) {
    final song = allSongs[x];
    allSongAudioList.add(
      Audio.file(song.uri!,
          metas: Metas(
            title: song.displayNameWOExt,
            artist: song.artist,
            id: song.id.toString(),
          )),
    );
  }
  return allSongAudioList;
}
  
}