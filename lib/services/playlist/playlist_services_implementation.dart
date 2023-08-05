import 'dart:developer';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/models/playlist/playlist_model/playlist_model.dart';
import 'package:music_player/models/playlist/playlist_services.dart';
import 'package:music_player/views/splash_screen/splash_screen.dart';

class PlaylistServicesImplementations implements PlaylistSevices {
  String playListDbName = 'playlist_db';

  @override
  Future<void> createNewPlaylist(
      {required AudioPlayListModel newPlaylist}) async {
    log('inside');
    final playListDb = await Hive.openBox<AudioPlayListModel>(playListDbName);
    log('after open box');
    await playListDb.put(newPlaylist.playlistName, newPlaylist);
    log(playListDb.values.length.toString());
    getAllPlayList();
    //  playListDb.close();
  }

  @override
  Future<void> removePlayleist({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<List<AudioPlayListModel>> getAllPlayList() async {
    final playListDb = await Hive.openBox<AudioPlayListModel>(playListDbName);
    List<AudioPlayListModel> allPlaylists = [];
    allPlaylists.addAll(playListDb.values);
    return allPlaylists;
  }

  @override
  Future<void> addSongToPlayList(
      {required String key, required int songId}) async {
    final playListDb = await Hive.openBox<AudioPlayListModel>(playListDbName);
    var playlistAudio = playListDb.get(key);
    if (playlistAudio != null) {
      String playlistName = playlistAudio.playlistName;
      List<int> playListSongs = [];
      playListSongs.addAll(playlistAudio.playListSongs);
      playListSongs.insert(0, songId);
      AudioPlayListModel audioPlayListModel = AudioPlayListModel(
          playlistName: playlistName, playListSongs: playListSongs);
      playListDb.put(key, audioPlayListModel);
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
    final playListDb = await Hive.openBox<AudioPlayListModel>(playListDbName);
    final playlist = playListDb.get(playlistId);
    if (playlist == null) {
      return [];
    } else {
      List<Audio> songList = [];
      for (var i = 0; i < fetchSongs.allSongAudioList.length; i++) {
        for (var j = 0; j < playlist.playListSongs.length; j++) {
          if (fetchSongs.allSongAudioList[i].metas.id ==
              playlist.playListSongs[j].toString()) {
            songList.add(fetchSongs.allSongAudioList[i]);
          }
        }
      }
      return songList;
    }
  }
}
