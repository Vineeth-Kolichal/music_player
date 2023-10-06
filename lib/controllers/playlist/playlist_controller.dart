import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music_player/models/playlist/playlist_model/playlist_model.dart';
import 'package:music_player/services/playlist/playlist_services_implementation.dart';

class PlayListController extends GetxController {
  var playListSongsList = <Audio>[].obs;

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
    allPlaylists
        .addAll((await playlistServicesImplementations.getAllPlayList()));
  }

  Future<bool> checkSongExist(
      {required String key, required int songId}) async {
    return await playlistServicesImplementations.isSongExist(
        key: key, songId: songId);
  }

  void addSongIdToPlayList({required String key, required int songId}) async {
    await playlistServicesImplementations.addSongToPlayList(
        name: key, songId: songId);
  }

  void getPlaylistSongs({required String playlistId}) async {
    playListSongsList.value = await playlistServicesImplementations
        .getPlayListSong(playlistId: playlistId);
  }

  bool isPnameExist(String pLname) {
    for (AudioPlayListModel x in allPlaylists) {
      if (x.playlistName == pLname) {
        return true;
      }
    }
    return false;
  }

  Future<void> deletePlaylist(String key) async {
    playlistServicesImplementations.removePlaylist(key: key);
    getAllPlayList();
  }

  void removeFromPlayList({required String key, required int songId}) {
    playlistServicesImplementations.removeFromPlaylist(
        key: key, songId: songId);
    getPlaylistSongs(playlistId: key);
    getAllPlayList();
  }
}
