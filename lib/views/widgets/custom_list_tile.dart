import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:music_player/controllers/favorite/favorite_controller.dart';
import 'package:music_player/util/constants.dart';
import 'package:music_player/services/favorite/favorite_services_implementation.dart';
import 'package:music_player/views/add_to_play_list/add_to_play_list.dart';
import 'package:music_player/views/widgets/custom_marquee_text.dart';
import 'package:music_player/views/widgets/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.songIndex,
    required this.allSongsAudioList,
    required this.songId,
    this.isInPlaylist = false,
  });
  final int songIndex;
  final List<Audio> allSongsAudioList;
  final int songId;
  final bool isInPlaylist;
  @override
  Widget build(BuildContext context) {
    FavoriteInListTileController favoriteInListTileController =
        FavoriteInListTileController();
    Audio song = allSongsAudioList[songIndex];
    final size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final bool isFav =
          await favoriteServiceImplementation.isInFavoriteDb(songId: songId);
      favoriteInListTileController.setFavorite(isFav);
    });
    return InkWell(
      onTap: () async {
        await assetsAudioPlayer.stop();
        await assetsAudioPlayer.open(
            showNotification: true,
            Playlist(audios: allSongsAudioList, startIndex: songIndex),
            autoStart: true);

        // ignore: use_build_context_synchronously
        showMiniPlayer(
          context: context,
          songIndex: songIndex,
          allSongsAudioList: allSongsAudioList,
        );
      },
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Row(children: [
          LeadingAvathar(song: song),
          kwidthTen,
          SongDetails(size: size, song: song),
          Trailing(
              isInPlayList: isInPlaylist,
              size: size,
              songIndex: songIndex,
              favoriteInListTileController: favoriteInListTileController,
              songId: songId),
        ]),
      ),
    );
  }
}

class Trailing extends StatelessWidget {
  const Trailing({
    super.key,
    required this.size,
    required this.songIndex,
    required this.favoriteInListTileController,
    required this.songId,
    required this.isInPlayList,
  });

  final Size size;
  final int songIndex;
  final FavoriteInListTileController favoriteInListTileController;
  final int songId;
  final bool isInPlayList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.21,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlayerBuilder.current(
            player: assetsAudioPlayer,
            builder: (context, playingAudio) {
              final assetId = playingAudio.audio.audio.metas.id;

              return Visibility(
                visible: songId.toString() == assetId,
                child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: MiniMusicVisualizer(
                    color: Colors.green,
                    width: 3,
                    height: 12,
                  ),
                ),
              );
            },
          ),
          isInPlayList
              ? Obx(() {
                  if (favoriteInListTileController.isFavorite.value) {
                    return InkWell(
                      onTap: () {
                        favoriteScreenController.removeFromFavorite(songId);
                        favoriteInListTileController.changeFavorite();
                      },
                      child: const Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.green,
                      ),
                    );
                  } else {
                    return InkWell(
                        onTap: () {
                          favoriteScreenController.addToFavorite(songId);
                          favoriteInListTileController.changeFavorite();
                        },
                        child: const Icon(CupertinoIcons.heart));
                  }
                })
              : PopupMenuButton<MenuItem>(
                  offset: Offset.zero,
                  splashRadius: 5,
                  onSelected: (MenuItem item) {
                    if (item == MenuItem.playlist) {
                      Get.to(() => AddToPlayList(songId: songId),
                          transition: Transition.downToUp);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<MenuItem>>[
                      PopupMenuItem<MenuItem>(
                        onTap: () {
                          if (!favoriteInListTileController.isFavorite.value) {
                            favoriteScreenController.addToFavorite(songId);
                          } else {
                            favoriteScreenController.removeFromFavorite(songId);
                          }

                          favoriteInListTileController.changeFavorite();
                        },
                        value: MenuItem.favorite,
                        child: Center(
                          child: Obx(() {
                            if (favoriteInListTileController.isFavorite.value) {
                              return const Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Colors.green,
                                  ),
                                  Text('Remove from favorite')
                                ],
                              );
                            } else {
                              return const Row(
                                children: [
                                  Icon(CupertinoIcons.heart),
                                  Text('Add to favorite')
                                ],
                              );
                            }
                          }),
                        ),
                      ),
                      const PopupMenuItem<MenuItem>(
                        value: MenuItem.playlist,
                        child: Center(
                            child: Row(
                          children: [
                            Icon(Icons.playlist_add),
                            Text('Add to playlist')
                          ],
                        )),
                      ),
                    ];
                  },
                ),
        ],
      ),
    );
  }
}

class SongDetails extends StatelessWidget {
  const SongDetails({
    super.key,
    required this.size,
    required this.song,
  });
  final Audio song;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            width: size.width * 0.55,
            child: CustomMarqueeText(
              songName: song.metas.title ?? 'Song title',
            ),
          ),
          SizedBox(
              height: 20,
              width: size.width * 0.55,
              child: Text(
                maxLines: 1,
                song.metas.artist ?? '<Unknown>',
                overflow: TextOverflow.fade,
              ))
        ],
      ),
    );
  }
}

class LeadingAvathar extends StatelessWidget {
  const LeadingAvathar({
    super.key,
    required this.song,
  });
  final Audio song;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 3,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 59, 58, 58),
            borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: QueryArtworkWidget(
            artworkClipBehavior: Clip.none,
            nullArtworkWidget: Image.asset(
              'assets/images/default_music_thumbnail.jpg',
              fit: BoxFit.cover,
            ),
            // controller: audioQuery,
            id: int.parse(song.metas.id!),
            type: ArtworkType.AUDIO,
          ),
        ),
      ),
    );
  }
}
