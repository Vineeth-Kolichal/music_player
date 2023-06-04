import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/presentation/add_to_play_list/add_to_play_list.dart';

void createPlayListDialoge() {
  TextEditingController playlistNameController = TextEditingController();
  Get.dialog(AlertDialog(
    content: TextFormField(
      controller: playlistNameController,
      decoration: const InputDecoration(hintText: 'Enter playlist name'),
    ),
    title: const Text('Create New Playlist'),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          )),
      ElevatedButton(
        onPressed: () {
          playListController.createPlaylist(playlistNameController.text.trim());
          Get.back();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: const Text('Create'),
      )
    ],
  ));
}
