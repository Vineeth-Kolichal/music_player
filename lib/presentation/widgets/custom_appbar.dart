import 'package:flutter/material.dart';
import 'package:music_player/core/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, this.leading, this.center, this.trailing, this.bottom});
  final Widget? leading;
  final Widget? center;
  final Widget? trailing;
  final Widget? bottom;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [kblackColor, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
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
                SizedBox(
                  child: trailing,
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
