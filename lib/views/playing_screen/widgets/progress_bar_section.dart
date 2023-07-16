import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player/util/constants.dart';

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
                  assetsAudioPlayer.seek(duration);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
