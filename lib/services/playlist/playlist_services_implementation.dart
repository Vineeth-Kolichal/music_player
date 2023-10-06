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
            'CREATE TABLE playlist (id INTEGER PRIMARY KEY,name VARCHAR(15))');
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
    await playListDb.rawInsert(
        'INSERT INTO playlist (name) VALUES (?)', [newPlaylist.playlistName]);
    final playListDb1 = await Hive.openBox<AudioPlayListModel>(playListDbName);
    await playListDb1.put(newPlaylist.playlistName, newPlaylist);
    // getAllPlayList();
    //  playListDb.close();
  }

  @override
  Future<void> removePlaylist({required String key}) async {
    final playListDb = await Hive.openBox<AudioPlayListModel>(playListDbName);
    await playListDb.delete(key);
  }

  @override
  Future<List<AudioPlayListModel>> getAllPlayList() async {
    final playLists = await playListDb.rawQuery('SELECT * FROM playlist');
    log(playLists.toString());
    final playListDb2 = await Hive.openBox<AudioPlayListModel>(playListDbName);
    List<AudioPlayListModel> allPlaylists = [];
    allPlaylists.addAll(playListDb2.values);
    return allPlaylists;
  }

  @override
  Future<void> addSongToPlayList(
      {required String name, required int songId}) async {
    final playlist = await playListDb
        .rawQuery('SELECT id FROM playlist WHERE name=?', [name]);
    await playListSongsDb.rawInsert(
        'INSERT INTO playlistsongs (songId,playlistId) VALUES(?,?)',
        [songId, playlist[0]['id']]);

    final playListDb1 = await Hive.openBox<AudioPlayListModel>(playListDbName);
    var playlistAudio = playListDb1.get(name);
    if (playlistAudio != null) {
      String playlistName = playlistAudio.playlistName;
      List<int> playListSongs = [];
      playListSongs.addAll(playlistAudio.playListSongs);
      playListSongs.insert(0, songId);
      AudioPlayListModel audioPlayListModel = AudioPlayListModel(
          playlistName: playlistName, playListSongs: playListSongs);
      playListDb1.put(name, audioPlayListModel);
    }
  }

  Future<void> removeFromPlaylist(
      {required String key, required int songId}) async {
    final playListDb = await Hive.openBox<AudioPlayListModel>(playListDbName);
    var playlistAudio = playListDb.get(key);
    if (playlistAudio != null) {
      String playlistName = playlistAudio.playlistName;
      List<int> playListSongs = [];
      playListSongs.addAll(playlistAudio.playListSongs);
      playListSongs.remove(songId);
      AudioPlayListModel audioPlayListModel = AudioPlayListModel(
          playlistName: playlistName, playListSongs: playListSongs);
      playListDb.put(key, audioPlayListModel);
    }
  }

  Future<bool> isSongExist({required String key, required int songId}) async {
    final playListDb = await Hive.openBox<AudioPlayListModel>(playListDbName);
    var playlistAudio = playListDb.get(key);
    if (playlistAudio != null) {
      if (playlistAudio.playListSongs.contains(songId)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<List<Audio>> getPlayListSong({required String playlistId}) async {
    final playlist = await playListDb
        .rawQuery('SELECT id FROM playlist WHERE name=?', [playlistId]);

    final playListSongList = await playListSongsDb.rawQuery(
        'SELECT songId FROM playlistsongs WHERE playlistId = ?',
        [playlist[0]['id']]);
    log(playListSongList.toString());
    final playListDb1 = await Hive.openBox<AudioPlayListModel>(playListDbName);
    final playlist1 = playListDb1.get(playlistId);
    if (playlist1 == null) {
      return [];
    } else {
      List<Audio> songList = [];
      for (var i = 0; i < fetchSongs.allSongAudioList.length; i++) {
        for (var j = 0; j < playlist1.playListSongs.length; j++) {
          if (fetchSongs.allSongAudioList[i].metas.id ==
              playlist1.playListSongs[j].toString()) {
            songList.add(fetchSongs.allSongAudioList[i]);
          }
        }
      }
      return songList;
    }
  }
}
