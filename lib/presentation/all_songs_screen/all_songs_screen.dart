import 'package:flutter/material.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/infrastructure/data_sources/fetch_songs.dart';
import 'package:music_player/presentation/widgets/custom_list_tile.dart';

class AllSongsScreen extends StatelessWidget {
  const AllSongsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.separated(
          itemBuilder: (ctx, index) {
            return CustomListTile(
              song: FetchSongs.allSongs[index],
            );
          },
          separatorBuilder: (ctx, index) {
            return kheightTen;
          },
          itemCount: FetchSongs.allSongs.length),
    );
  }
}
