import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/infrastructure/favorite/favorite_services_implementation.dart';
import 'package:music_player/presentation/widgets/custom_list_tile.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    favoriteScreenController.getAllFavoritesSongs();
    favoriteScreenController.changeLoadingState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        favoriteScreenController.changeLoadingState();
      },
    );
    return SafeArea(
      child: favoriteScreenController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Obx(() {
                if (favoriteScreenController.favoriteSongsList.isEmpty) {
                  return const Center(
                    child: Text('No favorite songs found'),
                  );
                }
                return ListView.separated(
                    itemBuilder: (ctx, index) {
                      final favoriteSong =
                          favoriteScreenController.favoriteSongsList[index];
                      return CustomListTile(
                        songId: int.parse(favoriteSong.metas.id!),
                        allSongsAudioList:
                            favoriteScreenController.favoriteSongsList,
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
