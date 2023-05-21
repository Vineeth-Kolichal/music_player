import 'dart:developer';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/infrastructure/data_sources/fetch_songs.dart';
import 'package:music_player/presentation/widgets/custom_list_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongsScreen extends StatelessWidget {
  const AllSongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Audio> allSongAudioList = [];
    for (var x = 0; x < allSongsController.allSongs.length; x++) {
      SongModel song = allSongsController.allSongs[x];
      allSongAudioList.add(Audio.file(song.uri!));
    }
    log('${allSongAudioList.length}');
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
