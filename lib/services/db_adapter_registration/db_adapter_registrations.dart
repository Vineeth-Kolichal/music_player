import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/models/playlist/playlist_model/playlist_model.dart';

Future<void> registerDbAdapter() async {
  if (!Hive.isAdapterRegistered(AudioPlayListModelAdapter().typeId)) {
    Hive.registerAdapter(AudioPlayListModelAdapter());
  }
}
