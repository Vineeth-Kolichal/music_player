import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/presentation/playing_screen/playing_screen.dart';
import 'package:music_player/presentation/widgets/custom_marquee_text.dart';
import 'package:on_audio_query/on_audio_query.dart';

void showMiniPlayer({required BuildContext context, required SongModel song}) {
  final Size size = MediaQuery.of(context).size;
  showBottomSheet(
      enableDrag: false,
      context: context,
      builder: (ctx) {
        return InkWell(
          onTap: () {
            Get.to(
              PlayingScreen(),
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
                        child: CustomMarqueeText(songName: song.displayName),
                      ),
                    ),
                    Text(song.artist ?? '<Unknown>')
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
                            child: Icon(CupertinoIcons.stop)),
                        InkWell(
                            onTap: () {
                              assetsAudioPlayer.playOrPause();
                            },
                            child: Icon(CupertinoIcons.play_arrow)),
                        InkWell(
                            onTap: () {},
                            child: Icon(CupertinoIcons.forward_end))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
