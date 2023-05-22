import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/application/favorite_screen/favorite_screen_controller.dart';
import 'package:music_player/domain/favorite/favorite_model/favorite_model.dart';
import 'package:music_player/domain/favorite/favorite_services.dart';

FavoriteScreenController favoriteScreenController =
    Get.put(FavoriteScreenController());

class FavoriteServiceImplementation extends FavoriteServices {
  final favoriteDbName = 'FavoriteDB';
  factory FavoriteServiceImplementation() {
    return FavoriteServiceImplementation._internal();
  }
  @override
  Future<void> addToFavorites({required FavoriteModel favorite}) async {
    final favDB = await Hive.openBox<FavoriteModel>(favoriteDbName);
    favDB.put(favorite.id, favorite);
  }

  @override
  Future<void> getAllFavoriteSongId() async {
    final favDB = await Hive.openBox<FavoriteModel>(favoriteDbName);
    favoriteScreenController.favoriteSongsList.clear();
    favoriteScreenController.favoriteSongsList.addAll(favDB.values);
  }

  @override
  Future<void> removeFromFavorites({required int songId}) async {
    final favDB = await Hive.openBox<FavoriteModel>(favoriteDbName);
    await favDB.delete(songId);
  }

  FavoriteServiceImplementation._internal();

  @override
  Future<bool> isInFavoriteDb({required int songId}) async {
    final favDB = await Hive.openBox<FavoriteModel>(favoriteDbName);
    final bool isContain = favDB.containsKey(songId);
    return isContain;
  }
}
