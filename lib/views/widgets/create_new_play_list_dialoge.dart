import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/views/add_to_play_list/add_to_play_list.dart';

void createPlayListDialoge() {
  TextEditingController playlistNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Get.dialog(AlertDialog(
    content: Form(
      key: formKey,
      child: TextFormField(
        controller: playlistNameController,
        decoration: const InputDecoration(hintText: 'Enter playlist name'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter plalist name';
          } else {
            if (playListController.isPnameExist(value)) {
              return 'Playlist name alredy exist';
            } else {
              return '';
            }
          }
        },
        onChanged: (value) {
          formKey.currentState!.validate();
        },
      ),
    ),
    title: const Text('Create New Playlist'),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(),
          )),
      ElevatedButton(
        onPressed: () {
          log('message');
          //if (formKey.currentState!.validate()) {
          playListController.createPlaylist(playlistNameController.text.trim());
          Get.back();
          //}
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
