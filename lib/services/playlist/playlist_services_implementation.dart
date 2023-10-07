import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/models/playlist/playlist_model/playlist_model.dart';
import 'package:music_player/models/playlist/playlist_services.dart';
import 'package:music_player/views/splash_screen/splash_screen.dart';
import 'package:sqflite/sqflite.dart';

class PlaylistServicesImplementations implements PlaylistSevices {
  String playListDbName = 'playlist_db';

  static late Database playListDb;
  static late Database playListSongsDb;
  static Future<void> initDatabase() async {
    playListDb = await openDatabase(
      'playlist_db',
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE playlist (id INTEGER PRIMARY KEY,name VARCHAR(15), count INTEGER)');
      },
    );
    playListSongsDb = await openDatabase(
      'playlistSongs_db',
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE playlistsongs (id INTEGER PRIMARY KEY,songId INTEGER, playlistId INTEGER)');
      },
    );
  }

  @override
  Future<void> createNewPlaylist(
      {required AudioPlayListModel newPlaylist}) async {
    await playListDb.rawInsert('INSERT INTO playlist (name,count) VALUES (?,?)',
        [newPlaylist.playlistName, 0]);
    
  }

  @override
  Future<void> removePlaylist({required int id}) async {
    await playListDb.rawDelete('DELETE FROM playlist WHERE id=? ', [id]);
    await playListSongsDb
        .rawDelete('DELETE FROM playlistsongs WHERE playlistId=? ', [id]);

  
  }

  @override
  Future<List<AudioPlayListModel>> getAllPlayList() async {
    List<AudioPlayListModel> allPlaylists = [];
    final playLists = await playListDb.rawQuery('SELECT * FROM playlist');
    for (var i = 0; i < playLists.length; i++) {
      allPlaylists.add(AudioPlayListModel.fromMap(playLists[i]));
    }
    
    return allPlaylists;
  }

  @override
  Future<void> addSongToPlayList(
      {required String name, required int songId}) async {
    final playlist = await playListDb
        .rawQuery('SELECT id,count FROM playlist WHERE name=?', [name]);
    await playListSongsDb.rawInsert(
        'INSERT INTO playlistsongs (songId,playlistId) VALUES(?,?)',
        [songId, playlist[0]['id']]);
    int currentCount = playlist[0]['count'] as int;
    await playListDb.rawUpdate('UPDATE playlist SET count=? WHERE id=?',
        [currentCount + 1, playlist[0]['id']]);

  }

  Future<void> removeFromPlaylist(
      {required String playListName, required int songId}) async {
    final playlist = await playListDb
        .rawQuery('SELECT id,count FROM playlist WHERE name=?', [playListName]);
    await playListSongsDb.rawDelete(
        'DELETE FROM playlistsongs WHERE playlistId=? AND songId=? ',
        [playlist[0]['id'], songId]);
    int currentCount = playlist[0]['count'] as int;
    await playListDb.rawUpdate('UPDATE playlist SET count=? WHERE id=?',
        [currentCount - 1, playlist[0]['id']]);

  }

  Future<bool> isSongExist(
      {required String playListName, required int songId}) async {
    final playlist = await playListDb
        .rawQuery('SELECT id FROM playlist WHERE name=?', [playListName]);

    final playListSongList = await playListSongsDb.rawQuery(
        'SELECT songId FROM playlistsongs WHERE playlistId = ? AND songId=?',
        [playlist[0]['id'], songId]);

    if (playListSongList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
   
  }

  Future<List<Audio>> getPlayListSong({required String playListName}) async {
    List<Audio> songList = [];
    final playlist = await playListDb
        .rawQuery('SELECT id FROM playlist WHERE name=?', [playListName]);

    final playListSongList = await playListSongsDb.rawQuery(
        'SELECT songId FROM playlistsongs WHERE playlistId = ?',
        [playlist[0]['id']]);
    for (var i = 0; i < fetchSongs.allSongAudioList.length; i++) {
      for (var j = 0; j < playListSongList.length; j++) {
        if (fetchSongs.allSongAudioList[i].metas.id ==
            playListSongList[j]['songId'].toString()) {
          songList.add(fetchSongs.allSongAudioList[i]);
        }
      }
    }

    return songList;
  }
}
