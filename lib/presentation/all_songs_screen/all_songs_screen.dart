import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/presentation/splash_screen/splash_screen.dart';
import 'package:music_player/presentation/widgets/custom_list_tile.dart';

class AllSongsScreen extends StatelessWidget {
  const AllSongsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1000));
        await fetchSongs.fetchSongs();
      },
      child: Scrollbar(
        interactive: true,
        thickness: 5,
        radius: const Radius.circular(10),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ListView.separated(
              itemBuilder: (ctx, index) {
                Audio song = fetchSongs.allSongAudioList[index];

                return CustomListTile(
                  songId: int.parse(song.metas.id!),
                  allSongsAudioList: fetchSongs.allSongAudioList,
                  songIndex: index,
                );
              },
              separatorBuilder: (ctx, index) {
                return kheightFive;
              },
              itemCount: fetchSongs.allSongAudioList.length),
        ),
      ),
    );
  }
}
