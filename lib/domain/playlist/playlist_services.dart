import 'package:on_audio_query/on_audio_query.dart';

abstract class PlaylistSevices {
  Future<void> createNewPlaylist({required PlaylistModel newPlaylist});
  Future<void> removePlayleist({required int id});
}
