import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/favorite/favorite_controller.dart';
import 'package:music_player/controllers/playing_screen/playing_controller.dart';
import 'package:music_player/models/lyrics_model/lyrics_model.dart';
import 'package:music_player/services/lyrics/fetch_lyrics.dart';
import 'package:music_player/util/constants.dart';
import 'package:music_player/services/favorite/favorite_services_implementation.dart';
import 'package:music_player/views/widgets/custom_appbar.dart';
import 'widgets/artwork_section.dart';
import 'widgets/buttons_section.dart';
import 'widgets/progress_bar_section.dart';
import 'widgets/title_and_artist_section.dart';

PlayingController playingController = PlayingController();

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({super.key, required this.song, required this.songId});
  final Audio song;
  final int songId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FavoriteServiceImplementation favoriteServiceImplementation =
        FavoriteServiceImplementation();
    FavoriteInListTileController favoriteInListTileController =
        FavoriteInListTileController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final bool isFav =
          await favoriteServiceImplementation.isInFavoriteDb(songId: songId);
      favoriteInListTileController.setFavorite(isFav);
    });
    return SafeArea(
      child: Scaffold(
        body: assetsAudioPlayer.builderCurrent(builder: (context, playing) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            playingController.fetchLyricsFomApi(
                title: playing.audio.audio.metas.title ?? '',
                artist: playing.audio.audio.metas.artist ?? '');
          });

          int id = int.parse(playing.audio.audio.metas.id!);
          return Stack(children: [
            ListView(
              children: [
                Hero(
                  tag: 'art',
                  child: ArtworkSection(id: id),
                ),
                TitleArtistSection(
                    playing: playing,
                    favoriteInListTileController: favoriteInListTileController,
                    songId: songId),
                kheightTen,
                const ProgressBarSection(),
                const ButtonsSection(),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 73, 72, 72),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Lyrics',
                            style: TextStyle(fontSize: 20),
                          ),
                          Divider(),
                          kheightFive,
                          Obx(() {
                            if (playingController.model.isEmpty) {
                              return Text(
                                'No lyrics found🧐',
                                style: TextStyle(fontSize: 15),
                              );
                            } else {
                              return Text(playingController.model[0]?.message
                                      ?.body?.lyrics?.lyricsBody ??
                                  '');
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            CustomAppBar(
              enableGradient: true,
              leading: InkWell(
                child: const Icon(CupertinoIcons.chevron_down),
                onTap: () {
                  Get.back();
                },
              ),
              center: const Text(
                'N o w  P l a y i n g',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              trailing: const SizedBox(width: 20),
            ),
          ]);
        }),
      ),
    );
  }
}
