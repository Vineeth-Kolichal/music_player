import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/util/colors.dart';
import 'package:music_player/services/db_adapter_registration/db_adapter_registrations.dart';
import 'package:music_player/views/splash_screen/splash_screen.dart';

bool hasStoragePermission = false;
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await registerDbAdapter();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
      home: const SplashScreen(),
      // home: HomeScreen(),
    );
  }
}
