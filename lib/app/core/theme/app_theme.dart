import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

part "text_theme.dart";

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
    ),
    fontFamily: "Overpass",
    textTheme: textTheme,
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(AppColors.white),
    )),
    iconTheme: IconThemeData(color: AppColors.white),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(AppColors.white),
    )),
  );
}
