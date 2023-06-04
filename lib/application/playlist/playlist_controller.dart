import 'dart:developer';

import 'package:get/get.dart';
import 'package:music_player/domain/playlist/playlist_model/playlist_model.dart';
import 'package:music_player/infrastructure/playlist/playlist_services_implementation.dart';

class PlayListController extends GetxController {
  PlaylistServicesImplementations playlistServicesImplementations =
      PlaylistServicesImplementations();
  var allPlaylists = <AudioPlayListModel>[].obs;

  void createPlaylist(String newPlaylistname) async {
    AudioPlayListModel newPlaylist =
        AudioPlayListModel(playlistName: newPlaylistname, playListSongs: []);
    await playlistServicesImplementations.createNewPlaylist(
        newPlaylist: newPlaylist);
    getAllPlayList();
  }

  void getAllPlayList() async {
    allPlaylists.clear();
    allPlaylists.addAll(await playlistServicesImplementations.getAllPlayList());
    log('${allPlaylists[0].playListSongs.length}');
  }

  void addSongIdToPlayList({required String key, required int songId}) {
    playlistServicesImplementations.addSongToPlayList(key: key, songId: songId);
  }
}
