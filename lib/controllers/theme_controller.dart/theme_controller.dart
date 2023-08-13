import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/util/theme.dart';

class ThemController extends GetxController {
  RxBool isDark = false.obs;
  Future<bool> getTheme() async {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    final themeDB = await Hive.openBox<bool>('theme_db');
    if (themeDB.isEmpty) {
      isDark.value = (brightness == Brightness.dark);
      setTheme((brightness == Brightness.dark));
      return (brightness == Brightness.dark);
    } else {
      bool? theme = themeDB.get('theme');
      if (theme != null) {
        isDark.value = theme;
        return theme;
      }
    }
    return (brightness == Brightness.dark);
  }

  void setTheme(bool value) async {
    isDark.value = value;
    final themeDB = await Hive.openBox<bool>('theme_db');
    themeDB.put('theme', value);
  }
}
