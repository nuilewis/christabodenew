import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

///Themes

///Light Theme

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    appBarTheme: appBarTheme,
    primaryColor: kPurple80,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: kDark40),
    primaryIconTheme: IconThemeData(color: kDark40),
    cardTheme: CardTheme(
      color: kCardColorLightTheme,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
    ),
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      bodyLarge: kBodyBold.copyWith(color: kDark),
      bodyMedium: kBody.copyWith(color: kDark),
      displayLarge: kHeading.copyWith(color: kDark),
      displayMedium: kHeadingLight.copyWith(color: kDark),
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: kPurple,
        brightness: Brightness.light,
        primary: kPurple80,
        secondary: kGreen),
  );
}

///Dark Theme

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
      appBarTheme: appBarTheme,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: kPurple,
      iconTheme: IconThemeData(color: Colors.white.withOpacity(.6)),
      primaryIconTheme: IconThemeData(color: Colors.white.withOpacity(.6)),
      cardTheme: CardTheme(
        color: kCardColorDarkTheme,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
      ),
      fontFamily: 'Poppins',
      textTheme: TextTheme(
        bodyLarge: kBodyBold.copyWith(color: Colors.white),
        bodyMedium: kBody.copyWith(color: Colors.white),
        displayLarge: kHeading.copyWith(color: Colors.white),
        displayMedium: kHeadingLight.copyWith(color: Colors.white),
      ),
      cardColor: kCardColorDarkTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kPurple80,
        brightness: Brightness.dark,
        primary: kPurple80,
        secondary: kGreen,
      ));
}

AppBarTheme appBarTheme = const AppBarTheme(
  backgroundColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
  systemOverlayStyle: SystemUiOverlayStyle.light,
  elevation: 0,
);
