import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music_player/models/favorite/favorite_model/favorite_model.dart';
import 'package:music_player/services/favorite/favorite_services_implementation.dart';

class FavoriteScreenController extends GetxController {
  FavoriteServiceImplementation favorite = FavoriteServiceImplementation();
  RxBool isLoading = true.obs;
  var favoriteSongsList = <Audio>[].obs;

  void changeLoadingState() {
    if (isLoading.value) {
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  void removeFromFavorite(int id) async {
    await favorite.removeFromFavorites(songId: id);
    getAllFavoritesSongs();
  }

  void addToFavorite(int id) async {
    favorite.addToFavorites(favorite: FavoriteModel(id: id));
  }

  void getAllFavoritesSongs() async {
    List<Audio> favSongs = await favorite.getAllFavoriteSongId();
    favoriteSongsList.clear();
    favoriteSongsList.addAll(favSongs);
  }
}
