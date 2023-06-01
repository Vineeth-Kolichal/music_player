import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_player/domain/favorite/favorite_model/favorite_model.dart';

abstract class FavoriteServices {
  Future<void> addToFavorites({required FavoriteModel favorite});
  Future<List<Audio>> getAllFavoriteSongId();
  Future<void> removeFromFavorites({required int songId});
  Future<bool> isInFavoriteDb({required int songId});
}
