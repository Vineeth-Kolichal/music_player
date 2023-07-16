import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/home_screen/home_screen_controller.dart';
import 'package:music_player/views/all_songs_screen/all_songs_screen.dart';
import 'package:music_player/views/favorites_screen/favorites_screen.dart';
import 'package:music_player/views/play_list_screen/play_list_screen.dart';
import 'package:music_player/views/settings_screen/settings_screen.dart';
import 'package:music_player/views/widgets/bottom_navigation.dart';
import 'package:music_player/views/widgets/create_new_play_list_dialoge.dart';
import 'package:music_player/views/widgets/custom_appbar.dart';

HomeScreenController homeScreenController = Get.put(HomeScreenController());

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<Widget> screens = const [
    AllSongsScreen(),
    FavoritesScreen(),
    PlayListScreen(),
    SettingsScreen()
  ];
  final List<String> title = [
    'All Songs',
    'Favorate Songs',
    'Playlists',
    'Settings'
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(homeScreenController.index.value == 0 ? 100 : 60),
          child: CustomAppBar(
            bottom: Obx(() {
              if (homeScreenController.index.value == 0) {
                return CupertinoSearchTextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    allSongsController.serarchSongs(value.trim());
                  },
                );
              } else {
                return const SizedBox();
              }
            }),
            leading: Obx(
              () => Text(
                title[homeScreenController.index.value],
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            trailing: homeScreenController.index.value == 2
                ? InkWell(
                    onTap: () {
                      createPlayListDialoge();
                    },
                    child: const Icon(Icons.add))
                : const SizedBox(),
          ),
        ),
        body: Obx(() => screens[homeScreenController.index.value]),
        bottomNavigationBar: const BottomNavigationWidget()));
  }
}
