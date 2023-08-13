import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/util/constants.dart';
import 'package:music_player/views/more_screen/more_screen.dart';

class ProgressBarSection extends StatelessWidget {
  const ProgressBarSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: size.width * 0.2,
        child: Center(
          child: PlayerBuilder.currentPosition(
            player: assetsAudioPlayer,
            builder: (context, duration) {
              final totalDuration =
                  assetsAudioPlayer.current.value?.audio.duration;
              return Obx(() => ProgressBar(
                    progress: duration,
                    total: totalDuration!,
                    progressBarColor: const Color.fromARGB(255, 118, 187, 116),
                    baseBarColor: themController.isDark.value
                        ? Colors.white.withOpacity(0.24)
                        : Colors.grey,
                    bufferedBarColor: Colors.white.withOpacity(0.24),
                    thumbColor: themController.isDark.value
                        ? Colors.white
                        : Colors.green,
                    barHeight: 4.0,
                    thumbRadius: 7.0,
                    onSeek: (duration) {
                      assetsAudioPlayer.seek(duration);
                    },
                  ));
            },
          ),
        ),
      ),
    );
  }
}
