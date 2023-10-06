import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/services/db_adapter_registration/db_adapter_registrations.dart';
import 'package:music_player/services/favorite/favorite_services_implementation.dart';
import 'package:music_player/services/playlist/playlist_services_implementation.dart';
import 'package:music_player/util/theme.dart';
import 'package:music_player/views/more_screen/more_screen.dart';
import 'package:music_player/views/splash_screen/splash_screen.dart';

bool hasStoragePermission = false;
late bool theme;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoriteServiceImplementation.initDatabase();
  await PlaylistServicesImplementations.initDatabase();
  await Hive.initFlutter();
  await registerDbAdapter();
  theme = await themController.getTheme();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyMusic());
}

class MyMusic extends StatelessWidget {
  const MyMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: theme ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

