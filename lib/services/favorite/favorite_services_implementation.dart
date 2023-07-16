import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/controllers/favorite_screen/favorite_screen_controller.dart';
import 'package:music_player/models/favorite/favorite_model/favorite_model.dart';
import 'package:music_player/models/favorite/favorite_services.dart';
import 'package:music_player/views/splash_screen/splash_screen.dart';

FavoriteScreenController favoriteScreenController =
    Get.put(FavoriteScreenController());

class FavoriteServiceImplementation implements FavoriteServices {
  List<FavoriteModel> favoriteSongIdList = [];
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
  Future<List<Audio>> getAllFavoriteSongId() async {
    List<Audio> favSongsList = [];
    final favDB = await Hive.openBox<FavoriteModel>(favoriteDbName);
    favoriteSongIdList.clear();
    favoriteSongIdList.addAll(favDB.values);
    for (var i = 0; i < fetchSongs.allSongAudioList.length; i++) {
      for (var j = 0; j < favoriteSongIdList.length; j++) {
        if (fetchSongs.allSongAudioList[i].metas.id ==
            favoriteSongIdList[j].id.toString()) {
          favSongsList.add(fetchSongs.allSongAudioList[i]);
        }
      }
    }
    return favSongsList;
  }

  @override
  Future<void> removeFromFavorites({required int songId}) async {
    final favDB = await Hive.openBox<FavoriteModel>(favoriteDbName);
    await favDB.delete(songId);
  }

  @override
  Future<bool> isInFavoriteDb({required int songId}) async {
    final favDB = await Hive.openBox<FavoriteModel>(favoriteDbName);
    final bool isContain = favDB.containsKey(songId);
    return isContain;
  }

  FavoriteServiceImplementation._internal();
}

FavoriteServiceImplementation favoriteServiceImplementation =
    FavoriteServiceImplementation();
