import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/application/favorite/favorite_controller.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/domain/favorite/favorite_model/favorite_model.dart';
import 'package:music_player/infrastructure/data_sources/fetch_songs.dart';
import 'package:music_player/infrastructure/favorite/favorite_services_implementation.dart';
import 'package:music_player/presentation/widgets/custom_marquee_text.dart';
import 'package:music_player/presentation/widgets/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.songIndex,
    required this.allSongsAudioList,
    required this.songId,
  });
  final int songIndex;
  final List<Audio> allSongsAudioList;
  final int songId;
  @override
  Widget build(BuildContext context) {
    FavoriteServiceImplementation favoriteServiceImplementation =
        FavoriteServiceImplementation();
    FavoriteInListTileController favoriteInListTileController =
        FavoriteInListTileController();
    Audio song = allSongsAudioList[songIndex];
    final size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final bool isFav =
          await favoriteServiceImplementation.isInFavoriteDb(songId: songId);
      favoriteInListTileController.setFavorite(isFav);
    });
    return InkWell(
      onTap: () async {
        await assetsAudioPlayer.stop();
        await assetsAudioPlayer.open(
            showNotification: true,
            Playlist(audios: allSongsAudioList, startIndex: songIndex),
            autoStart: true);
        // ignore: use_build_context_synchronously
        showMiniPlayer(
            context: context,
            songIndex: songIndex,
            allSongsAudioList: allSongsAudioList);
      },
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Row(children: [
          LeadingAvathar(song: song),
          kwidthTen,
          SongDetails(size: size, song: song),
          Obx(
            () => IconButton(
              onPressed: () async {
                if (!favoriteInListTileController.isFavorite.value) {
                  FavoriteModel favorite = FavoriteModel(
                      id: songId,
                      uri: song.path,
                      displayName: song.metas.title ?? 'Song title',
                      artist: song.metas.artist ?? '<Unknown>');
                  await favoriteServiceImplementation.addToFavorites(
                      favorite: favorite);
                } else {
                  await favoriteServiceImplementation.removeFromFavorites(
                      songId: int.parse(song.metas.id!));
                }

                favoriteInListTileController.changeFavorite();
              },
              icon: favoriteInListTileController.isFavorite.value
                  ? const Icon(
                      CupertinoIcons.heart_fill,
                      color: Colors.green,
                    )
                  : const Icon(CupertinoIcons.heart),
            ),
          ),
        ]),
      ),
    );
  }
}

class SongDetails extends StatelessWidget {
  const SongDetails({
    super.key,
    required this.size,
    required this.song,
  });
  final Audio song;
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
            child: CustomMarqueeText(
              songName: song.metas.title ?? 'Song title',
            ),
          ),
          SizedBox(
              height: 20,
              width: size.width * 0.6,
              child: Text(
                maxLines: 1,
                song.metas.artist ?? '<Unknown>',
                overflow: TextOverflow.fade,
              ))
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
  final Audio song;
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
            id: int.parse(song.metas.id!),
            type: ArtworkType.AUDIO,
          ),
        ),
      ),
    );
  }
}
