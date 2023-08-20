import 'dart:developer';

import 'package:get/get.dart';
import 'package:music_player/models/lyrics_model/lyrics_model.dart';
import 'package:music_player/services/lyrics/fetch_lyrics.dart';

class PlayingController extends GetxController {
  RxInt currentPlayingIndex = 0.obs;
  RxBool isPlaying = false.obs;
  RxBool isRepeat = false.obs;
  RxBool isShuffle = false.obs;
  RxBool isLyricsLoading = true.obs;
  RxList model = <LyricsModel>[].obs;
  void playOrPause(bool playing) {
    isPlaying.value = playing;
  }

  void setCurrentPlayingIndex(int index) {
    currentPlayingIndex.value = index;
  }

  void setNextSongIndex(int nextIndex) {
    currentPlayingIndex.value = nextIndex;
  }

  void setPreviousSongIndex(int prevIndex) {
    currentPlayingIndex.value = prevIndex;
  }

  void shuffle() {
    isShuffle.value = !isShuffle.value;
  }

  void repeat() {
    isRepeat.value = !isRepeat.value;
  }

  void fetchLyricsFomApi(
      {required String title, required String artist}) async {
    model.clear();
    final a = await fetchLyrics(title: title, artist: artist);
    log(a.runtimeType.toString());
    log('${a?.message?.body?.lyrics?.lyricsBody}');
    if (a != null) {
      model.add(a);
    }
  }
}
