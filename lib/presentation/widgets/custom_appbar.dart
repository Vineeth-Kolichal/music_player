import 'package:flutter/material.dart';
import 'package:music_player/core/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.leading, this.center, this.trailing});
  final Widget? leading;
  final Widget? center;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              child: leading,
            ),
            SizedBox(
              child: center,
            ),
            SizedBox(
              child: trailing,
            )
          ],
        ),
      ),
    );
  }
}
