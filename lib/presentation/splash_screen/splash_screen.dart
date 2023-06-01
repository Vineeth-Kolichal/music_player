import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:music_player/infrastructure/data_sources/fetch_songs.dart';
import 'package:music_player/infrastructure/permmisions/check_storage_permmission.dart';
import 'package:music_player/main.dart';
import 'package:music_player/presentation/home_screen/home_screen.dart';
FetchSongs fetchSongs = FetchSongs();
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      hasStoragePermission =
          await CheckPermmission.checkAndRequestPermissions();
      if (hasStoragePermission) {
        await fetchSongs.fetchSongs();
      }
      await Future.delayed(const Duration(milliseconds: 5000), () {
        Get.offAll(HomeScreen());
      });
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: size.width * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      minHeight: 5,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
