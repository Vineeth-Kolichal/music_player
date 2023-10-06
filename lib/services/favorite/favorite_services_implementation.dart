import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/favorite_screen/favorite_screen_controller.dart';
import 'package:music_player/models/favorite/favorite_model/favorite_model.dart';
import 'package:music_player/models/favorite/favorite_services.dart';
import 'package:music_player/views/splash_screen/splash_screen.dart';
import 'package:sqflite/sqflite.dart';

FavoriteScreenController favoriteScreenController =
    Get.put(FavoriteScreenController());

class FavoriteServiceImplementation implements FavoriteServices {
  static late Database db;
  static Future<void> initDatabase() async {
    db = await openDatabase(
      'favorite_db',
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE favorite (id INTEGER PRIMARY KEY,songId INTEGER)');
      },
    );
  }

  List<FavoriteModel> favoriteSongIdList = [];
  final favoriteDbName = 'FavoriteDB';
  factory FavoriteServiceImplementation() {
    return FavoriteServiceImplementation._internal();
  }
  @override
  Future<void> addToFavorites({required FavoriteModel favorite}) async {
    db.rawInsert('INSERT INTO favorite (songId) VALUES(?)', [favorite.id]);
  }

  @override
  Future<List<Audio>> getAllFavoriteSongId() async {
    final List<Map<String, Object?>> favSongs =
        await db.rawQuery('SELECT * FROM favorite');
    List<Audio> favSongsList = [];
    log(favSongs.toString());

    for (var i = 0; i < fetchSongs.allSongAudioList.length; i++) {
      for (var j = 0; j < favSongs.length; j++) {
        if (fetchSongs.allSongAudioList[i].metas.id ==
            favSongs[j]['songId'].toString()) {
          favSongsList.add(fetchSongs.allSongAudioList[i]);
        }
      }
    }

    return favSongsList;
  }

  @override
  Future<void> removeFromFavorites({required int songId}) async {
    await db.rawDelete('DELETE FROM favorite WHERE songId=?', [songId]);
  }

  @override
  Future<bool> isInFavoriteDb({required int songId}) async {
    final List<Map<String, Object?>> favList =
        await db.rawQuery('SELECT * FROM favorite WHERE songId=?', [songId]);

    return favList.isNotEmpty;
  }

  FavoriteServiceImplementation._internal();
}

FavoriteServiceImplementation favoriteServiceImplementation =
    FavoriteServiceImplementation();
