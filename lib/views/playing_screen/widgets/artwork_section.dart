import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/util/colors.dart';
import 'package:music_player/views/more_screen/more_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtworkSection extends StatelessWidget {
  const ArtworkSection({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.width * 1.2,
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
        Obx(
          () => Container(
            height: size.width * 1.2,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  themController.isDark.value
                      ? const Color.fromARGB(68, 0, 0, 0)
                      : const Color.fromARGB(69, 255, 255, 255),
                  themController.isDark.value ? kblackColor : Colors.white
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
