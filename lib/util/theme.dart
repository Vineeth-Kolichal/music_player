import 'package:flutter/material.dart';
import 'package:music_player/util/colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey,
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    selectedIconTheme: IconThemeData(
      color: Colors.black,
    ),
    backgroundColor: Color.fromARGB(255, 226, 228, 226),
  ),
);
ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.green,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 34, 34, 34),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    unselectedIconTheme: IconThemeData(color: Colors.grey),
    selectedIconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: kblackColor,
);
