import 'package:music_player/domain/favorite/favorite_model/favorite_model.dart';

abstract class FavoriteServices {
  Future<void> addToFavorites({required FavoriteModel favorite});
  Future<void> getAllFavoriteSongId();
  Future<void> removeFromFavorites({required int songId});
  Future<bool> isInFavoriteDb({required int songId});
}
