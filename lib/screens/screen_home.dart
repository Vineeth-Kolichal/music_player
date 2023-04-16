import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player/screens/pages/page_all_songs.dart';
import 'package:music_player/screens/pages/page_favorites.dart';
import 'package:music_player/screens/pages/page_playlists.dart';
import 'package:music_player/screens/pages/page_settings.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;
  List<Widget> pages = [
    PageAllSongs(),
    PageFavorites(),
    PagePlaylists(),
    PageSettings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: pages.elementAt(_currentIndex),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavyBar(
          containerHeight: 60,
          //backgroundColor: Colors.black,
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.library_music_outlined),
              title: Text('All Songs'),
              //  activeColor: Colors.green,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.favorite_border),
              title: Text('Favorites'),
              // activeColor: Colors.purpleAccent,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.playlist_play),
              title: Text(
                'Playlists',
              ),
              // activeColor: Colors.pink,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              //  activeColor: Colors.blue,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
