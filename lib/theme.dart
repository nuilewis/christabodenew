import 'package:flutter/material.dart';
import 'constants.dart';

///Themes

///Light Theme

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
      appBarTheme: appBarTheme,
      primaryColor: kBlue,
      primaryColorLight: kLightBlue,
      primaryColorDark: kBlueDark,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: kDark),
      primaryIconTheme: const IconThemeData(color: kDark),
      cardTheme: CardTheme(
        color: kDark20,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
      ),
      fontFamily: 'Poppins',
      textTheme:  TextTheme(
        bodyText1: kBodyBold.copyWith(color: kDark),
        bodyText2: kBody.copyWith(color: kDark),
        headline1: kHeading.copyWith(color: kDark),
        headline2: kHeadingLight.copyWith(color: kDark),
      ),
      //colorScheme: ColorScheme.light().copyWith(secondary: cLightGrey),
      colorScheme: const ColorScheme.light().copyWith(secondary: kFuchsiaLight),
      cardColor: kDark20);
}

///Dark Theme

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
      appBarTheme: appBarTheme,
      primaryColor: kBlue,
      primaryColorLight: kLightBlue,
      primaryColorDark: kBlueDark,
      scaffoldBackgroundColor: Color.fromARGB(255, 28, 28, 28),
      brightness: Brightness.dark,
      backgroundColor: kDark,
      iconTheme: const IconThemeData(color: Colors.white),
      primaryIconTheme: const IconThemeData(color: Colors.white),
      cardTheme: CardTheme(
        color: kDark80,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
      ),
      fontFamily: 'Poppins',
      textTheme: TextTheme(
        bodyText1: kBodyBold.copyWith(color: Colors.white),
        bodyText2: kBody.copyWith(color: Colors.white),
        headline1: kHeading.copyWith(color: Colors.white),
        headline2: kHeadingLight.copyWith(color: Colors.white),
      ),
      //colorScheme: ColorScheme.light().copyWith(secondary: cLightGrey),
      colorScheme: const ColorScheme.dark().copyWith(secondary: kFuchsia),
      cardColor: KCardColorDarkTheme);
}

AppBarTheme appBarTheme = const AppBarTheme(
  backgroundColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  elevation: 0,
);
