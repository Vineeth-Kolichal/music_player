import 'package:on_audio_query/on_audio_query.dart';

class FetchSongs {
  static List<SongModel> allSongs = [];
  static Future<void> fetchSongs() async {
    OnAudioQuery audioQuery = OnAudioQuery();
    allSongs.addAll(await audioQuery.querySongs());
  }
}
