import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/domain/favorite/favorite_model/favorite_model.dart';

Future<void> registerDbAdapter() async {
  if (!Hive.isAdapterRegistered(FavoriteModelAdapter().typeId)) {
    Hive.registerAdapter(FavoriteModelAdapter());
  }
}