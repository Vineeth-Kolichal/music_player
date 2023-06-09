import 'package:get/get.dart';

class PlayingController extends GetxController {
  RxInt currentPlayingIndex = 0.obs;
  RxBool isPlaying = false.obs;
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
}
