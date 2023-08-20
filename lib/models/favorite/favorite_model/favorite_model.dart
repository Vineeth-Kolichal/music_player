import 'package:hive_flutter/hive_flutter.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 1)
class FavoriteModel {
  @HiveField(0)
  final int id;
 
  FavoriteModel({
    required this.id,
    
  });
}
