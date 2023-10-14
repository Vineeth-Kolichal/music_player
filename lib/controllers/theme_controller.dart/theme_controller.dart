import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemController extends GetxController {
  RxBool isDark = false.obs;
  Future<bool> getTheme() async {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    SharedPreferences shared = await SharedPreferences.getInstance();
    final theme = shared.getBool('theme');
    if (theme == null) {
      isDark.value = (brightness == Brightness.dark);
      setTheme((brightness == Brightness.dark));
      return (brightness == Brightness.dark);
    } else {
      isDark.value = theme;
      return theme;
    }
  }

  void setTheme(bool value) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    await shared.setBool('theme', value);
    isDark.value = value;
  }
}
