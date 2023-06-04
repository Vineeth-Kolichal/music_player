import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/application/playlist/playlist_controller.dart';
import 'package:music_player/core/constants.dart';
import 'package:music_player/domain/playlist/playlist_model/playlist_model.dart';
import 'package:music_player/presentation/widgets/create_new_play_list_dialoge.dart';
import 'package:music_player/presentation/widgets/custom_appbar.dart';

PlayListController playListController = Get.put(PlayListController());

class AddToPlayList extends StatelessWidget {
  const AddToPlayList({super.key, required this.songId});
  final int songId;
  @override
  Widget build(BuildContext context) {
    playListController.getAllPlayList();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            leading: InkWell(
              child: const Icon(CupertinoIcons.chevron_down),
              onTap: () {
                Get.back();
              },
            ),
            center: const Text(
              'Add To PlayList',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            trailing: const SizedBox(width: 20),
          )),
      body: Column(children: [
        SizedBox(
          height: 100,
          width: double.infinity,
          child: Center(
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    createPlayListDialoge();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('New Playlist'))),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(() => ListView.separated(
              itemBuilder: (ctx, index) {
                AudioPlayListModel playlist =
                    playListController.allPlaylists[index];
                return ListTile(
                  onTap: () {
                    playListController.addSongIdToPlayList(
                        key: playlist.playlistName, songId: songId);
                    Get.back();
                  },
                  title: Text(playlist.playlistName),
                  subtitle: Text('${playlist.playListSongs.length} songs'),
                );
              },
              separatorBuilder: (ctx, index) {
                return Divider();
              },
              itemCount: playListController.allPlaylists.length)),
        ))
      ]),
    );
  }
}
