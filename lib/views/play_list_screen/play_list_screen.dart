import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/models/playlist/playlist_model/playlist_model.dart';
import 'package:music_player/views/add_to_play_list/add_to_play_list.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    playListController.getAllPlayList();
    return SafeArea(
        child: Center(
      child: Obx(() => Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0),
                itemBuilder: (ctx, index) {
                  AudioPlayListModel playList =
                      playListController.allPlaylists[index];
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/playlist_background.jpg'))),
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
                                  Text(
                                    playList.playlistName,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text('${playList.playListSongs.length} Songs')
                                ]),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 7,
                          top: 7,
                          child: InkWell(
                            onTap: () {},
                            child: const CircleAvatar(
                              radius: 17,
                              child: Icon(
                                CupertinoIcons.delete,
                                size: 18,
                              ),
                            ),
                          ))
                    ],
                  );
                },
                itemCount: playListController.allPlaylists.length),
          )),
    ));
  }
}
