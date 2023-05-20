import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:music_player/presentation/widgets/custom_appbar.dart';

class PlayingScreen extends StatelessWidget {
  const PlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
            leading: InkWell(
              child: Icon(CupertinoIcons.chevron_down),
              onTap: () {
                Get.back();
              },
            ),
            center: Text('Now Playing'),
            trailing: SizedBox(width: 20),
          ),
        ),
      ),
    );
  }
}
