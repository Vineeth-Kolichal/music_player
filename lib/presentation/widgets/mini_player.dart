import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/application/playing_screen/playing_controller.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/infrastructure/data_sources/fetch_songs.dart';
import 'package:music_player/presentation/playing_screen/playing_screen.dart';
import 'package:music_player/presentation/widgets/custom_marquee_text.dart';
import 'package:on_audio_query/on_audio_query.dart';

void showMiniPlayer(
    {required BuildContext context,
    required int songIndex,
    required List<Audio> allSongsAudioList}) {
  PlayingController playingController = Get.put(PlayingController());
  playingController.setCurrentPlayingIndex(songIndex);
  assetsAudioPlayer
      .playlistPlayAtIndex(playingController.currentPlayingIndex.value);
  final Size size = MediaQuery.of(context).size;
  showBottomSheet(
      enableDrag: false,
      context: context,
      builder: (ctx) {
        return assetsAudioPlayer.builderCurrent(builder: (context, isPlaying) {
          int id = int.parse(isPlaying.audio.audio.metas.id!);
          // String songName = isPlaying.audio.audio.metas.title??'';
          return InkWell(
            onTap: () {
              Get.to(
                PlayingScreen(
                    songId: id,
                    song: allSongsController
                        .allSongs[playingController.currentPlayingIndex.value]),
                transition: Transition.downToUp,
              );
            },
            child: SizedBox(
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    color: Colors.amber,
                    child: QueryArtworkWidget(
                      artworkClipBehavior: Clip.none,
                      nullArtworkWidget: Image.asset(
                        'assets/images/default_music_thumbnail.jpg',
                        fit: BoxFit.cover,
                      ),
                      // controller: audioQuery,
                      id: id,
                      type: ArtworkType.AUDIO,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                        ),
                        child: SizedBox(
                          height: 20,
                          width: size.width * 0.5,
                          child: CustomMarqueeText(
                              songName: assetsAudioPlayer.getCurrentAudioTitle),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: size.width * 0.5,
                        child: Text(
                          assetsAudioPlayer.getCurrentAudioArtist,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 55,
                    width: size.width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                assetsAudioPlayer.stop();
                                Get.back();
                              },
                              child: const Icon(CupertinoIcons.stop)),
                          InkWell(onTap: () {
                            assetsAudioPlayer.playOrPause();
                            playingController.playOrPause(assetsAudioPlayer.isPlaying.value);
                          }, child: Obx(() {
                            if (playingController.isPlaying.value) {
                              return const Icon(CupertinoIcons.play_arrow);
                            } else {
                              return const Icon(CupertinoIcons.pause);
                            }
                          })),
                          InkWell(
                            onTap: () {
                              assetsAudioPlayer.next();
                              if (allSongsController.allSongs.length ==
                                  playingController.currentPlayingIndex.value) {
                                playingController.setCurrentPlayingIndex(0);
                              } else {
                                playingController.setNextSongIndex(
                                    playingController
                                            .currentPlayingIndex.value +
                                        1);
                              }
                            },
                            child: const Icon(CupertinoIcons.forward_end),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      });
}
