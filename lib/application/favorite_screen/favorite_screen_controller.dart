import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteScreenController extends GetxController {
  RxBool isLoading = true.obs;
  RxList favoriteSongsList = [].obs;
  void changeLoadingState() {
    if (isLoading.value) {
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  void addToFavoriteSongModelList(List<SongModel> songs) {
    favoriteSongsList.clear();
    favoriteSongsList.addAll(songs);
  }
}
