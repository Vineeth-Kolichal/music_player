import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/playing_screen/playing_controller.dart';
import 'package:music_player/util/constants.dart';

PlayingController _playingController = Get.put(PlayingController());

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.width * 0.2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              _playingController.repeat();
              assetsAudioPlayer.toggleLoop();
            },
            child: Obx(
              () => Icon(
                CupertinoIcons.repeat,
                color: _playingController.isRepeat.value
                    ? Colors.green
                    : Colors.grey,
              ),
            ),
          ),
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
          ),
          InkWell(
            onTap: () {
              _playingController.shuffle();
              assetsAudioPlayer.toggleShuffle();
            },
            child: Obx(
              () => Icon(
                CupertinoIcons.shuffle,
                color: _playingController.isShuffle.value
                    ? Colors.green
                    : Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
