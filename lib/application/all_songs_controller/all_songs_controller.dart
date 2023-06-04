
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music_player/presentation/splash_screen/splash_screen.dart';

class AllSongsController extends GetxController {
  var songsList = <Audio>[].obs;
  void serarchSongs(String query) {
    songsList.clear();
    songsList.addAll(fetchSongs.allSongAudioList
        .where((element) =>
            element.metas.title!.toLowerCase().contains(query.toLowerCase()))
        .toList());
  }
}
