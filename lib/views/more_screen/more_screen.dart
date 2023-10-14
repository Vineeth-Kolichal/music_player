import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controllers/theme_controller.dart/theme_controller.dart';
import 'package:music_player/util/theme.dart';
import 'package:music_player/views/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

ThemController themController = Get.put(ThemController());

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Expanded(
            child: ListView(
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Switch Theme',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.sun_max),
                        Obx(() => Switch(
                              value: themController.isDark.value,
                              onChanged: (value) {
                                themController.setTheme(value);
                                Get.changeTheme(value ? darkTheme : lightTheme);
                                if (!value) {
                                }
                              },
                            )),
                        const Icon(CupertinoIcons.moon),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => const PrivacyPolicyScreen());
              },
              title: const Text('Privacy Policy'),
            ),
            ListTile(
              title: const Text('Version'),
              subtitle: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (BuildContext context,
                    AsyncSnapshot<PackageInfo> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.version,
                      style: const TextStyle(fontSize: 12),
                    );
                  } else {
                    return const Text(
                      'Version Loading...',
                      style: TextStyle(fontSize: 12),
                    );
                  }
                },
              ),
            )
          ],
        )),
        const SizedBox(
          height: 60,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(),
                Text(
                  'Made with 💚 by Vineeth',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
