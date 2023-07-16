import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/all_songs_controller/all_songs_controller.dart';
import 'package:music_player/util/constants.dart';
import 'package:music_player/views/splash_screen/splash_screen.dart';
import 'package:music_player/views/widgets/custom_list_tile.dart';

AllSongsController allSongsController = Get.put(AllSongsController());

class AllSongsScreen extends StatelessWidget {
  const AllSongsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    allSongsController.serarchSongs('');
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
          child: Obx(() {
            if (allSongsController.songsList.isEmpty) {
              return const Center(
                child: Text('No songs found'),
              );
            }
            return ListView.separated(
                itemBuilder: (ctx, index) {
                  Audio song = allSongsController.songsList[index];

                  return CustomListTile(
                    songId: int.parse(song.metas.id!),
                    allSongsAudioList: allSongsController.songsList,
                    songIndex: index,
                  );
                },
                separatorBuilder: (ctx, index) {
                  return kheightFive;
                },
                itemCount: allSongsController.songsList.length);
          }),
        ),
      ),
    );
  }
}
