
import 'package:flutter/material.dart';
import 'package:music_player/util/colors.dart';
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
          decoration: const  BoxDecoration(
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
    );
  }
}
