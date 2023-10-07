import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/views/add_to_play_list/add_to_play_list.dart';

void deletePlayListDialoge({required int id}) {
  Get.dialog(AlertDialog(
    content: const Text('Click delete to delete playlist else click cancel'),
    title: const Text('Are you sure?'),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
          )),
      ElevatedButton(
        onPressed: () {
          playListController.deletePlaylist(id);
          Get.back();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: const Text('Delete'),
      )
    ],
  ));
}
