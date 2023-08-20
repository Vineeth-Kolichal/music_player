import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/models/playlist/playlist_model/playlist_model.dart';
import 'package:music_player/util/constants.dart';
import 'package:music_player/views/add_to_play_list/add_to_play_list.dart';
import 'package:music_player/views/play_list_screen/widgets/delete_playlist_dialoge.dart';
import 'package:music_player/views/play_list_view_screen/play_list_view_screen.dart';
import 'package:music_player/views/widgets/create_new_play_list_dialoge.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    playListController.getAllPlayList();
    return SafeArea(child: Center(
      child: Obx(() {
        if (playListController.allPlaylists.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No playlists found',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              kheightFive,
              const Text(
                "Click 'Create' to create\n new playlist",
                textAlign: TextAlign.center,
              ),
              kheightFive,
              ElevatedButton(
                onPressed: () {
                  createPlayListDialoge();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: const Text('Create'),
              )
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0),
              itemBuilder: (ctx, index) {
                AudioPlayListModel playList =
                    playListController.allPlaylists[index];
                return InkWell(
                  onTap: () {
                    Get.to(() => PlayListViewScreen(
                          playListModel: playListController.allPlaylists[index],
                        ));
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/playlist_background.jpg'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          color: const Color.fromARGB(167, 37, 37, 37),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Hero(
                                    tag: playList.playlistName,
                                    child: Text(
                                      playList.playlistName,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    '${playList.playListSongs.length} Songs',
                                    style:
                                        const TextStyle(color: Colors.white),
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 7,
                          top: 7,
                          child: InkWell(
                            onTap: () {
                              deletePlayListDialoge(
                                  playListName: playList.playlistName);
                            },
                            child: const CircleAvatar(
                              radius: 17,
                              child: Icon(
                                CupertinoIcons.delete,
                                size: 18,
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              },
              itemCount: playListController.allPlaylists.length),
        );
      }),
    ));
  }
}
