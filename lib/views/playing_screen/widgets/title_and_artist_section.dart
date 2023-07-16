
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/favorite/favorite_controller.dart';
import 'package:music_player/services/favorite/favorite_services_implementation.dart';

class TitleArtistSection extends StatelessWidget {
  const TitleArtistSection({
    super.key,
    required this.favoriteInListTileController,
    required this.songId,
    required this.playing,
  });

  final FavoriteInListTileController favoriteInListTileController;
  final int songId;
  final Playing playing;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.width * 0.15,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    playing.audio.audio.metas.title ?? 'No song name',
                    maxLines: 1,
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    playing.audio.audio.metas.artist ?? '<Unknown>',
                    style: const TextStyle(color: Colors.grey, fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Obx(() {
              return InkWell(
                onTap: () async {
                  if (!favoriteInListTileController.isFavorite.value) {
                    favoriteScreenController.addToFavorite(songId);
                  } else {
                    favoriteScreenController.removeFromFavorite(songId);
                  }
                  favoriteScreenController.getAllFavoritesSongs();
                  favoriteInListTileController.changeFavorite();
                },
                child: favoriteInListTileController.isFavorite.value
                    ? const Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.green,
                      )
                    : const Icon(CupertinoIcons.heart),
              );
            }),
          ],
        ),
      ),
    );
  }
}