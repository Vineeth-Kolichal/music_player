import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:music_player/core/colors.dart';
import 'package:music_player/presentation/widgets/custom_appbar.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({super.key, required this.song});
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
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
                    // controller: audioQuery,
                    id: song.id,
                    type: ArtworkType.AUDIO,
                  ),
                ),
                Container(
                  height: size.width,
                  width: size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent,Color.fromARGB(68, 0, 0, 0), kblackColor])),
                )
              ],
            )
          ],
        ),
        CustomAppBar(
          leading: InkWell(
            child: Icon(CupertinoIcons.chevron_down),
            onTap: () {
              Get.back();
            },
          ),
          center: Text(
            'Now Playing',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          trailing: SizedBox(width: 20),
        ),
      ]),
    );
  }
}
