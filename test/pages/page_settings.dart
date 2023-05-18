import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PageSettings extends StatelessWidget {
  PageSettings({super.key});
  final SwitchController controller = Get.put(SwitchController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: [
        ListTile(
            title: Text('Dark theme'),
            trailing: Obx(
              () {
                return Switch(
                  value: controller.switchValue.value,
                  onChanged: (value) async {
                    final themeDB = await Hive.openBox('theme');
                    controller.toggleSwitch(value);
                    if (value == true) {
                      Get.changeTheme(ThemeData.dark());
                      themeDB.put('theme', true);
                    } else {
                      Get.changeTheme(ThemeData.light());
                      themeDB.put('theme', false);
                    }
                  },
                );
              },
            ))
      ]),
    );
  }
}

class SwitchController extends GetxController {
  RxBool switchValue = false.obs;
  void toggleSwitch(bool value) {
    switchValue.value = value;
  }

  bool get isEnabled => switchValue.value;
}
