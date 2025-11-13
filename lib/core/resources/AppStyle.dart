import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.primaryColor,
      shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 5)),
    ),
    scaffoldBackgroundColor: ColorsManager.lightBackgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.primaryColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 22,
        color: ColorsManager.primaryColor,
      ),
      iconTheme: IconThemeData(color: ColorsManager.primaryColor),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: ColorsManager.primaryColor,
        padding: const EdgeInsets.all(8),
        side: const BorderSide(color: ColorsManager.primaryColor, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
          side: const BorderSide(color: ColorsManager.primaryColor, width: 1),
        ),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: ColorsManager.primaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blackColor,
      ),
      titleMedium: TextStyle(
        color: Color(0xff7B7B7B),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: ColorsManager.primaryColor,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.primaryColor,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: ColorsManager.primaryColor,
      background: ColorsManager.lightBackgroundColor,
      secondary: ColorsManager.blackColor,
      tertiary: Color(0xff7B7B7B),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.darkBackgroundColor,
      shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 5)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.darkBackgroundColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    scaffoldBackgroundColor: ColorsManager.darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 22,
        color: ColorsManager.primaryColor,
      ),
      iconTheme: IconThemeData(color: ColorsManager.primaryColor),
    ),
    colorScheme: const ColorScheme.dark(
      primary: ColorsManager.primaryColor,
      background: ColorsManager.darkBackgroundColor,
      secondary: ColorsManager.darkTextColor,
      tertiary: Color(0xffF4EBDC),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorsManager.darkTextColor,
      ),
      titleMedium: TextStyle(
        color: Color(0xffF4EBDC),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: ColorsManager.primaryColor,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.primaryColor,
      ),
    ),
  );
}
