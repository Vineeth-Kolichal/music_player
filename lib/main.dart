import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/core/colors.dart';
import 'package:music_player/infrastructure/data_sources/fetch_songs.dart';
import 'package:music_player/infrastructure/permmisions/check_storage_permmission.dart';
import 'package:music_player/presentation/home_screen/home_screen.dart';

bool hasStoragePermission = false;
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  hasStoragePermission = await CheckPermmission.checkAndRequestPermissions();
  if (hasStoragePermission) {
    await FetchSongs.fetchSongs();
  }
  runApp(const MyMusic());
}

class MyMusic extends StatelessWidget {
  const MyMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kblackColor,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
