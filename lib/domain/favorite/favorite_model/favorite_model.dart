import 'package:hive_flutter/hive_flutter.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class FavoriteModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String uri;
  @HiveField(2)
  final String displayName;
  @HiveField(3)
  final String artist;

  FavoriteModel({
    required this.id,
    required this.uri,
    required this.displayName,
    required this.artist,
  });
}
