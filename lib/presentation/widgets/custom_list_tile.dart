
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/infrastructure/data_sources/fetch_songs.dart';
import 'package:music_player/presentation/widgets/custom_marquee_text.dart';
import 'package:music_player/presentation/widgets/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key, required this.songIndex, required this.allSongsAudioList});
  final int songIndex;
  final List<Audio> allSongsAudioList;
  @override
  Widget build(BuildContext context) {
    final SongModel song = allSongsController.allSongs[songIndex];
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        await assetsAudioPlayer.stop();
        await assetsAudioPlayer.open(
            Playlist(audios: allSongsAudioList, startIndex: songIndex),
            autoStart: true);
        //assetsAudioPlayer.open(Audio.file(song.uri!));
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
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
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
            child: CustomMarqueeText(
              songName: song.displayName,
            ),
          ),
          SizedBox(
              height: 20,
              width: size.width * 0.6,
              child: Text(
                maxLines: 1,
                song.artist ?? '<Unknown>',
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
