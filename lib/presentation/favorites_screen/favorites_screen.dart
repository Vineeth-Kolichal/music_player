import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/domain/favorite/favorite_model/favorite_model.dart';
import 'package:music_player/infrastructure/data_sources/audio_list_conversion.dart';
import 'package:music_player/infrastructure/data_sources/fetch_songs.dart';
import 'package:music_player/infrastructure/favorite/favorite_services_implementation.dart';
import 'package:music_player/presentation/widgets/custom_list_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    favoriteScreenController.changeLoadingState();
    FavoriteServiceImplementation favoriteServiceImplementation =
        FavoriteServiceImplementation();

    List<Audio> favoriteSongAudioList = [];
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await favoriteServiceImplementation.getAllFavoriteSongId();
        favoriteSongAudioList =
            convertToAudioList(favoriteScreenController.favoriteSongsList);
        favoriteScreenController.changeLoadingState();
        print('object');
      },
    );
    return SafeArea(
      //child: Text('fav'),
      child: favoriteScreenController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(() {
                if (favoriteScreenController.favoriteSongsList.isEmpty) {
                  return Center(
                    child: Text('No favorite songs found'),
                  );
                }
                return ListView.separated(
                    itemBuilder: (ctx, index) {
                      FavoriteModel favoriteSong =
                          favoriteScreenController.favoriteSongsList[index];

                      return CustomListTile(
                        songId: favoriteSong.id,
                        allSongsAudioList: favoriteSongAudioList,
                        songIndex: index,
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return kheightFive;
                    },
                    itemCount:
                        favoriteScreenController.favoriteSongsList.length);
              }),
            ),
    );
  }
}
