import 'playlist_model/playlist_model.dart';

abstract class PlaylistSevices {
  Future<void> createNewPlaylist({required AudioPlayListModel newPlaylist});
  Future<void> removePlaylist({required String key});
  Future<List<AudioPlayListModel>> getAllPlayList();
  Future<void> addSongToPlayList({required String name, required int songId});
}
