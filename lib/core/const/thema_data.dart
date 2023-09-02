import 'package:flutter/material.dart';

import 'const.dart';

ThemeData buildThemeData() {
  return ThemeData(
    primaryColor: ColorStyle().primaryColor,
    scaffoldBackgroundColor: Colors.white,
    bottomSheetTheme:const BottomSheetThemeData(
      elevation: 12,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius:BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black
    ),
    colorScheme:
    ColorScheme.fromSeed(seedColor: ColorStyle().primaryColor),
    // useMaterial3: true,
  );
}
