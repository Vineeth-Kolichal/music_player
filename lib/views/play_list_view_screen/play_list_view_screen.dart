import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:music_player/models/playlist/playlist_model/playlist_model.dart';
import 'package:music_player/util/constants.dart';
import 'package:music_player/views/add_to_play_list/add_to_play_list.dart';
import 'package:music_player/views/widgets/custom_appbar.dart';
import 'package:music_player/views/widgets/custom_list_tile.dart';

class PlayListViewScreen extends StatelessWidget {
  const PlayListViewScreen({super.key, required this.playListModel});
  final AudioPlayListModel playListModel;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      playListController.getPlaylistSongs(
          playlistId: playListModel.playlistName);
      log(playListController.playListSongsList.toString());
    });
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          enableGradient: false,
          leading: InkWell(
            child: const Icon(CupertinoIcons.back),
            onTap: () {
              Get.back();
            },
          ),
          center: Hero(
            tag: playListModel.playlistName,
            child: Material(
              color: Colors.transparent,
              child: Text(
                playListModel.playlistName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Obx(() {
          if (playListController.playListSongsList.isEmpty) {
            return const Center(
              child: Text('No songs added'),
            );
          }

          return ListView.separated(
              itemBuilder: (ctx, index) {
                final favoriteSong =
                    playListController.playListSongsList[index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.black,
                        onPressed: (ctx) {
                          playListController.removeFromPlayList(
                              key: playListModel.playlistName,
                              songId: int.parse(favoriteSong.metas.id!));
                        },
                        icon: Icons.remove_circle_outline,
                        label: 'Remove',
                      )
                    ],
                  ),
                  child: CustomListTile(
                    isInPlaylist: true,
                    songId: int.parse(favoriteSong.metas.id!),
                    allSongsAudioList: playListController.playListSongsList,
                    songIndex: index,
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return kheightFive;
              },
              itemCount: playListController.playListSongsList.length);
        }),
      ),
    );
  }
}
