
import 'playlist_model/playlist_model.dart';

abstract class PlaylistSevices {
  Future<void> createNewPlaylist({required AudioPlayListModel newPlaylist});
  Future<void> removePlayleist({required int id});
  Future<List<AudioPlayListModel>> getAllPlayList();
  Future<void> addSongToPlayList({required String key,required int  songId});
}
