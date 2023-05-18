import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/core/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.song});
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Row(children: [
        LeadingAvathar(song: song),
        kwidthTen,
        SongDetails(size: size, song: song),
        IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
      ]),
    );
  }
}

class SongDetails extends StatelessWidget {
  const SongDetails({
    super.key,
    required this.size,
    required this.song,
  });
  final SongModel song;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            width: size.width * 0.6,
            child: Marquee(
              text: song.displayName,
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
            ),
          ),
          Text(song.artist ?? '<Unknown>')
        ],
      ),
    );
  }
}

class LeadingAvathar extends StatelessWidget {
  const LeadingAvathar({
    super.key,
    required this.song,
  });
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 3,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 59, 58, 58),
            borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: QueryArtworkWidget(
            artworkClipBehavior: Clip.none,
            nullArtworkWidget: Image.asset(
              'assets/images/default_music_thumbnail.jpg',
              fit: BoxFit.cover,
            ),
            // controller: audioQuery,
            id: song.id,
            type: ArtworkType.AUDIO,
          ),
        ),
      ),
    );
  }
}
