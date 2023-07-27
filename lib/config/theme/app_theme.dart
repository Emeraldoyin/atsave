import 'package:easysave/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: BACKGROUND_COLOR1,
      appBarTheme: const AppBarTheme(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(80.0),
            // bottomRight: Radius.elliptical(x, y)
          ),
        ),
        titleSpacing: 10,
        //   toolbarHeight: 100,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, color: HEADING_COLOR1, fontSize: 20),
        elevation: 0,
        centerTitle: false,
        // clipBehavior: Clip.hardEdge,
        color: APPBAR_COLOR1,
        iconTheme: IconThemeData(color: APPBAR_ICON_COLOR),
      ),
      // colorScheme: const ColorScheme.light(
      //   primary: BACKGROUND_COLOR1,
      //   onPrimary: HEADING_COLOR2,
      //   secondary: ICON_COLOR4,
      // ),
      cardTheme: const CardTheme(color: CARD_COLOR1),
      iconTheme: const IconThemeData(
        color: ICON_COLOR4,
      ),
      textTheme: const TextTheme(
          headlineMedium: TextStyle(
              fontFamily:
                  'ibm-plex-sans/assets/fonts/ibm-plex-sans/IBMPlexSans-BoldItalic.ttf',
              fontStyle: FontStyle.italic,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
              fontFamily:
                  'ibm-plex-sans/assets/fonts/ibm-plex-sans/IBMPlexSans-BoldItalic.ttf',
              fontStyle: FontStyle.italic,
              fontSize: 20,
              fontWeight: FontWeight.w800),
          displayLarge: TextStyle(
            color: HEADING_COLOR1,
            fontFamily:
                'ibm-plex-sans/assets/fonts/ibm-plex-sans/IBMPlexSans-Bold.ttf',
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            color: HEADING_COLOR1,
            fontFamily:
                'ibm-plex-sans/assets/fonts/ibm-plex-sans/IBMPlexSans-Bold.ttf',
          ),
          titleSmall: TextStyle(
            fontWeight: FontWeight.w700,
            color: HEADING_COLOR2,
            fontSize: 18.0,
          ),
          bodyMedium: TextStyle(
            height: 1.5,
            fontWeight: FontWeight.w600,
            color: HEADING_COLOR1,
            fontSize: 16.0,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            height: 1.5,
          )),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black, // Change the cursor color here
      ),
      navigationBarTheme: const NavigationBarThemeData(
        iconTheme: MaterialStatePropertyAll<IconThemeData>(
            IconThemeData(color: BUTTON_COLOR1)),
        indicatorColor: BUTTON_COLOR1,
        backgroundColor: BACKGROUND_COLOR2,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        iconSize: 30.r,
        backgroundColor: BUTTON_COLOR1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor:
                  const MaterialStatePropertyAll<Color>(Colors.white),
              textStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
                color: Colors.white,
                fontSize: 15,
              )),
              iconColor: const MaterialStatePropertyAll<Color>(Colors.white),
              // overlayColor: const MaterialStatePropertyAll<Color>(Colors.white),
              fixedSize: const MaterialStatePropertyAll<Size>(Size(135, 50)),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              backgroundColor:
                  MaterialStateProperty.all<Color>(BUTTON_COLOR1))),
      inputDecorationTheme: InputDecorationTheme(
          //hoverColor: Colors.black,
          hintStyle: const TextStyle(color: HINT_TEXT_COLOR, fontSize: 14),
          constraints: BoxConstraints(minWidth: 320.w, minHeight: 40.h),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          outlineBorder: const BorderSide(color: Colors.transparent),
          activeIndicatorBorder: const BorderSide(color: Colors.black),
          border:
              const OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none, color: Colors.white)),
          filled: true,
          iconColor: Colors.black,
          suffixIconColor: Colors.black,
          fillColor: Colors.white));

  static final ThemeData darkTheme = ThemeData(
    // brightness: Brightness.dark,
    scaffoldBackgroundColor: BACKGROUND_COLOR2,
    appBarTheme: const AppBarTheme(
      color: APPBAR_COLOR2,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: BACKGROUND_COLOR2,
      onPrimary: BACKGROUND_COLOR2,
      primaryContainer: HEADING_COLOR1,
      secondary: ICON_COLOR5,
    ),
    cardTheme: const CardTheme(
      color: APPBAR_COLOR2,
    ),
    iconTheme: const IconThemeData(
      color: CARD_COLOR1,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      titleSmall: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all<Color>(Colors.grey),
      thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            overlayColor: MaterialStateProperty.all<Color>(Colors.black26))),
  );
}
