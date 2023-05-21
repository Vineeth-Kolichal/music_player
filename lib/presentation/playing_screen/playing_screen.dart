import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:music_player/core/colors.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/presentation/widgets/custom_appbar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({super.key, required this.song, required this.songId});
  final SongModel song;
  final int songId;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: assetsAudioPlayer.builderCurrent(builder: (context, playing) {
        int id = int.parse(playing.audio.audio.metas.id!);
        return Stack(children: [
          ListView(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.width,
                    child: QueryArtworkWidget(
                      artworkClipBehavior: Clip.none,
                      nullArtworkWidget: Image.asset(
                        'assets/images/default_music_thumbnail.jpg',
                        fit: BoxFit.cover,
                      ),
                      id: id,
                      type: ArtworkType.AUDIO,
                    ),
                  ),
                  Container(
                    height: size.width,
                    width: size.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.transparent,
                          Color.fromARGB(68, 0, 0, 0),
                          kblackColor
                        ])),
                  )
                ],
              ),
              SizedBox(
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
                          Text(
                            playing.audio.audio.metas.artist ?? '<Unknown>',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const Icon(CupertinoIcons.heart)
                    ],
                  ),
                ),
              ),
              kheightTen,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                    height: size.width * 0.2,
                    child: Center(
                      child: PlayerBuilder.currentPosition(
                          player: assetsAudioPlayer,
                          builder: (context, duration) {
                            final totalDuration =
                                assetsAudioPlayer.current.value?.audio.duration;
                            return ProgressBar(
                              progress: duration,
                              total: totalDuration!,
                              progressBarColor: Colors.white,
                              baseBarColor: Colors.white.withOpacity(0.24),
                              bufferedBarColor: Colors.white.withOpacity(0.24),
                              thumbColor: Colors.white,
                              barHeight: 4.0,
                              thumbRadius: 7.0,
                              onSeek: (duration) {
                                // _player.seek(duration);
                              },
                            );
                          }),
                    )),
              ),
              SizedBox(
                height: size.width * 0.2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Center(
                        child: IconButton(
                            onPressed: () async {
                              await assetsAudioPlayer.previous();
                            },
                            icon: const Icon(
                              CupertinoIcons.backward_end,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: InkWell(
                        onTap: () {
                          assetsAudioPlayer.playOrPause();
                        },
                        child: PlayerBuilder.isPlaying(
                            player: assetsAudioPlayer,
                            builder: (context, isPlaying) {
                              if (isPlaying) {
                                return const Icon(
                                  CupertinoIcons.pause_circle_fill,
                                  size: 70,
                                );
                              } else {
                                return const Icon(
                                  CupertinoIcons.play_circle_fill,
                                  size: 70,
                                );
                              }
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: IconButton(
                          onPressed: () async {
                            await assetsAudioPlayer.next();
                          },
                          icon: const Icon(CupertinoIcons.forward_end)),
                    )
                  ],
                ),
              )
            ],
          ),
          CustomAppBar(
            leading: InkWell(
              child: const Icon(CupertinoIcons.chevron_down),
              onTap: () {
                Get.back();
              },
            ),
            center: const Text(
              'Now Playing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            trailing: const SizedBox(width: 20),
          ),
        ]);
      }),
    );
  }
}
