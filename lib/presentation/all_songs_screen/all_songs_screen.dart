
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/infrastructure/data_sources/audio_list_conversion.dart';
import 'package:music_player/infrastructure/data_sources/fetch_songs.dart';
import 'package:music_player/presentation/widgets/custom_list_tile.dart';

class AllSongsScreen extends StatelessWidget {
  const AllSongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Audio> allSongAudioList =
        convertToAudioList(allSongsController.allSongs);
   
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          await FetchSongs.fetchSongs();
        },
        child: Obx(() => ListView.separated(
            itemBuilder: (ctx, index) {
              return CustomListTile(
                allSongsAudioList: allSongAudioList,
                songIndex: index,
              );
            },
            separatorBuilder: (ctx, index) {
              return kheightFive;
            },
            itemCount: allSongsController.allSongs.length)),
      ),
    );
  }
}
