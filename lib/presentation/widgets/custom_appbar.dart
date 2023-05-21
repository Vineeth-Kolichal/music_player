import 'package:flutter/material.dart';
import 'package:music_player/core/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.leading, this.center, this.trailing});
  final Widget? leading;
  final Widget? center;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [kblackColor, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                child: leading,
              ),
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
