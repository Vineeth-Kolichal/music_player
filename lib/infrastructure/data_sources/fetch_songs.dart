import 'package:get/get.dart';
import 'package:music_player/application/all_songs_screen/all_songs_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

AllSongsController allSongsController = Get.put(AllSongsController());

class FetchSongs {
  // static List<SongModel> allSongs = [];
  static Future<void> fetchSongs() async {
    OnAudioQuery audioQuery = OnAudioQuery();
    allSongsController.addSongs(await audioQuery.querySongs());
// allSongs.addAll(await audioQuery.querySongs());
  }
}
