import 'package:get/get.dart';

class FavoriteInListTileController extends GetxController {
  RxBool isFavorite = false.obs;
  void changeFavorite() {
    if (isFavorite.value) {
      isFavorite.value = false;
    } else {
      isFavorite.value = true;
    }
  }

  void setFavorite(bool fav) {
    isFavorite.value = fav;
  }
}
