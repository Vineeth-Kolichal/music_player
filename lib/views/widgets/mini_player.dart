import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/playing_screen/playing_controller.dart';
import 'package:music_player/util/constants.dart';
import 'package:music_player/views/home_screen/home_screen.dart';
import 'package:music_player/views/playing_screen/playing_screen.dart';
import 'package:music_player/views/widgets/custom_marquee_text.dart';
import 'package:on_audio_query/on_audio_query.dart';

void showMiniPlayer(
    {required BuildContext context,
    required int songIndex,
    required List<Audio> allSongsAudioList}) {
  PlayingController playingController = Get.put(PlayingController());
  playingController.setCurrentPlayingIndex(songIndex);

  final Size size = MediaQuery.of(context).size;
  scaffoldKey.currentState?.showBottomSheet((context) {
    return assetsAudioPlayer.builderCurrent(builder: (context, isPlaying) {
      int id = int.parse(isPlaying.audio.audio.metas.id!);
      return MiniPlayer(
        allSongsAudioList: allSongsAudioList,
        songIndex: songIndex,
        id: id,
        playingController: playingController,
        size: size,
      );
    });
  }, enableDrag: false);
}

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    super.key,
    required this.id,
    required this.playingController,
    required this.size,
    required this.allSongsAudioList,
    required this.songIndex,
  });

  final int id;
  final PlayingController playingController;
  final Size size;
  final List<Audio> allSongsAudioList;
  final int songIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          PlayingScreen(
              songId: id,
              song: allSongsAudioList[
                  playingController.currentPlayingIndex.value]),
          transition: Transition.downToUp,
        );
      },
      child: SizedBox(
        height: 57,
        child: Column(
          children: [
            PlayerBuilder.currentPosition(
              player: assetsAudioPlayer,
              builder: (context, duration) {
                final totalDuration =
                    assetsAudioPlayer.current.value?.audio.duration;
                return ProgressBar(
                  timeLabelLocation: TimeLabelLocation.none,
                  progress: duration,
                  total: totalDuration!,
                  progressBarColor: Colors.green,
                  baseBarColor: Colors.white.withOpacity(0.24),
                  bufferedBarColor: Colors.white.withOpacity(0.24),
                  thumbColor: Colors.white,
                  barHeight: 2.0,
                  thumbRadius: 0.0,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: 'art',
                  child: SizedBox(
                    height: 55,
                    width: 55,
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
                            onTap: () async {
                              await assetsAudioPlayer.stop();
                              Get.back();
                            },
                            child: const Icon(CupertinoIcons.stop)),
                        InkWell(
                          onTap: () async {
                            await assetsAudioPlayer.playOrPause();
                          },
                          child: PlayerBuilder.isPlaying(
                            player: assetsAudioPlayer,
                            builder: (context, isPlaying) {
                              playingController.playOrPause(isPlaying);
                              if (isPlaying) {
                                return const Icon(CupertinoIcons.pause);
                              } else {
                                return const Icon(CupertinoIcons.play_arrow);
                              }
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await assetsAudioPlayer.next();
                            if (allSongsAudioList.length ==
                                playingController.currentPlayingIndex.value) {
                              playingController.setCurrentPlayingIndex(0);
                            } else {
                              playingController.setNextSongIndex(
                                  playingController.currentPlayingIndex.value +
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
          ],
        ),
      ),
    );
  }
}
