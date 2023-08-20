import 'package:flutter/material.dart';
import 'package:music_player/util/colors.dart';
import 'package:music_player/views/more_screen/more_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.center,
    this.trailing,
    this.bottom,
    this.enableGradient = false,
  });
  final Widget? leading;
  final Widget? center;
  final Widget? trailing;
  final Widget? bottom;
  final bool enableGradient;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: enableGradient
                  ? LinearGradient(colors: [
                      themController.isDark.value ? kblackColor : Colors.white,
                      Colors.transparent
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                  : null,
            ),
            height: 40,
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
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    child: trailing,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                child: bottom ??
                    const SizedBox(
                      height: 0,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
