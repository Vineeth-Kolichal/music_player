import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/views/home_screen/home_screen.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
          selectedFontSize: 10,
          unselectedFontSize: 10,
          onTap: (index) {
            homeScreenController.changeIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: homeScreenController.index.value,
          // backgroundColor: const Color.fromARGB(255, 37, 37, 37),
          // selectedItemColor: Colors.white,
          // unselectedItemColor: Colors.grey,
          // selectedIconTheme: const IconThemeData(
          //   color: Colors.white,
          // ),
          // unselectedIconTheme: const IconThemeData(color: Colors.grey),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.music_albums),
              label: 'All Songs',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_favorites_alt),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.music_note_list),
              label: 'Playlists',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.info),
              label: 'More',
            ),
          ]);
    });
  }
}
