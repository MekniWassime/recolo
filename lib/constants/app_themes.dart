import 'package:flutter/material.dart';
import 'package:recolo/constants/app_colors.dart';

class AppThemes {
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    bottomAppBarColor: AppColors.primaryColor,
    iconTheme: IconThemeData(
      color: AppColors.interactableColor.shade300,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.interactableColor,
        foregroundColor: Colors.white),
    appBarTheme: AppBarTheme(color: AppColors.primaryColor),
    primaryColor: AppColors.primaryColor,
    //primarySwatch: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: Typography.whiteCupertino,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColors.outlineColor),
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: AppColors.interactableColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.outlineColor,
        focusColor: AppColors.outlineColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.fadedText),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.fadedText),
        ),
        labelStyle: Typography.whiteCupertino.bodyText1),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          primary: AppColors.interactableColor.shade300,
          textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    ),
  );
}
