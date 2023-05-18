import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player/presentation/pages/page_all_songs.dart';
import 'package:music_player/presentation/pages/page_favorites.dart';
import 'package:music_player/presentation/pages/page_playlists.dart';
import 'package:music_player/presentation/pages/page_settings.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  bool _hasPermission = false;
  @override
  void initState() {
    super.initState();
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    audioQuery.setLogConfig(logConfig);
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    _hasPermission ? setState(() {}) : null;
  }

  int _currentIndex = 0;
  final _inactiveColor = Color.fromARGB(255, 2, 0, 0);
  List<Widget> pages = [PageFavorites(), PagePlaylists(), PageSettings()];
  List<String> appBarTitle = [
    'All Songs🎵🎶',
    ' Favorites💙',
    'Playlists',
    'Settings ⚙️'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color.fromARGB(255, 190, 241, 248),
      appBar: AppBar(
        titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 1, 2, 85),
            fontSize: 17,
            fontWeight: FontWeight.w600),
        actions: _currentIndex == 0
            ? [
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Icon(Icons.refresh))
              ]
            : _currentIndex == 2
                ? [IconButton(onPressed: () {}, icon: Icon(Icons.add))]
                : null,
        //centerTitle: true,
        backgroundColor: Color.fromARGB(255, 146, 205, 245),
        title: Text(
          appBarTitle[_currentIndex],
        ),
      ),
      body: _hasPermission
          ? _currentIndex == 0
              ? PageAllSongs(audioQuery: audioQuery)
              : pages.elementAt(_currentIndex - 1)
          : Center(
              child: noAccessToLibraryWidget(),
            ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return BottomNavyBar(
      backgroundColor: Color.fromARGB(255, 146, 205, 245),
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
          activeColor: Color.fromARGB(255, 1, 2, 85),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.favorite_border),
          title: Text('Favorites'),
          activeColor: Color.fromARGB(255, 1, 2, 85),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.playlist_play),
          title: Text(
            'Playlists',
          ),
          activeColor: Color.fromARGB(255, 1, 2, 85),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          activeColor: Color.fromARGB(255, 1, 2, 85),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}
