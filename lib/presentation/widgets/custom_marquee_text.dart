import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomMarqueeText extends StatelessWidget {
  const CustomMarqueeText({
    super.key,
    required this.songName,
  });

  final String songName;

  @override
  Widget build(BuildContext context) {
    return Marquee(
      text: songName,
      style: const TextStyle(fontSize: 17),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20,
      velocity: 25,
      pauseAfterRound: const Duration(seconds: 1),
      startPadding: 0,
      accelerationDuration: const Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }
}
