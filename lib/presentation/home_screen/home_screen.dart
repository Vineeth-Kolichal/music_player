import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:music_player/application/home_screen/home_screen_controller.dart';
import 'package:music_player/presentation/all_songs_screen/all_songs_screen.dart';
import 'package:music_player/presentation/favorites_screen/favorites_screen.dart';
import 'package:music_player/presentation/play_list_screen/play_list_screen.dart';
import 'package:music_player/presentation/search_screen/search_screen.dart';
import 'package:music_player/presentation/settings_screen/settings_screen.dart';
import 'package:music_player/presentation/widgets/bottom_navigation.dart';
import 'package:music_player/presentation/widgets/custom_appbar.dart';

HomeScreenController homeScreenController = Get.put(HomeScreenController());

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<Widget> screens = [
    AllSongsScreen(),
    FavoritesScreen(),
    PlayListScreen(),
    SettingsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: CustomAppBar(
                bottom: CupertinoSearchTextField(
                  keyboardType: TextInputType.none,
                  onTap: () {
                    Get.to(() => SearchScreen());
                  },
                ),
                leading: Text('all Songs')),
            preferredSize: Size.fromHeight(100)),
        body: Obx(() => screens[homeScreenController.index.value]),
        bottomNavigationBar: BottomNavigationWidget());
  }
}
