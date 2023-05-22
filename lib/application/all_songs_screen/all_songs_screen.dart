import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongsController extends GetxController {
  RxList allSongs = [].obs;
  // RxList allSongsUrlList = [].obs;
  void addSongs(List<SongModel> songs) {
    allSongs.clear();
    allSongs.addAll(songs);
  }
}
