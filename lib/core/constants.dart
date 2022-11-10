import 'package:flutter/material.dart';

///Colours

///----Blues-----///
//const Color cPrimaryColor = Color(0xFFC8C3FF);
const Color kLightBlue = Color(0xFFC0E8FF);
const Color kBlueDark = Color(0xFF0755C7);

const Color kBlue = Color(0xFF27A8F8);
Color kBlue80 = const Color(0xFF27A8F8).withOpacity(.8);
Color kBlue60 = const Color(0xFF27A8F8).withOpacity(.6);
Color kBlue40 = const Color(0xFF27A8F8).withOpacity(.4);
Color kBlue20 = const Color(0xFF27A8F8).withOpacity(.2);

const Color kDark = Color(0xFF2D2D2D);
Color kDark80 = const Color(0xFF2D2D2D).withOpacity(.8);
Color kDark60 = const Color(0xFF2D2D2D).withOpacity(.6);
Color kDark40 = const Color(0xFF2D2D2D).withOpacity(.4);
Color kDark20 = const Color(0xFF2D2D2D).withOpacity(.2);

const Color kCardColorDarkTheme = Color.fromARGB(255, 53, 53, 53);

///------Fuchsia-------///
const Color kFuchsiaLight = Color(0xFFFFC1D8);
const Color kFuchsia = Color(0xFFFC4684);
Color kFuchsia80 = const Color(0xFFFC4684).withOpacity(.8);
Color kFuchsia60 = const Color(0xFFFC4684).withOpacity(.6);
Color kFuchsia40 = const Color(0xFFFC4684).withOpacity(.4);
Color kFuchsia20 = const Color(0xFFFC4684).withOpacity(.2);
//const Color kFuchsia80 = Color(0xFFFF7DA9);

///-------Greens------///
const Color kGreenLight = Color(0xFFBAF2E4);

const Color kGreen = Color(0xFF20A663);
Color kGreen80 = const Color(0xFF20A663).withOpacity(.8);
Color kGreen60 = const Color(0xFF20A663).withOpacity(.6);
Color kGreen40 = const Color(0xFF20A663).withOpacity(.4);
Color kGreen20 = const Color(0xFF20A663).withOpacity(.2);

const double kDefaultPadding = 16.0;
const double kDefaultPadding2x = 32.0;

///----TextStyles----///
const TextStyle kHeading = TextStyle(fontWeight: FontWeight.w600, fontSize: 28);
const TextStyle kHeadingLight =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 28);
const TextStyle kBody = TextStyle(fontWeight: FontWeight.normal, fontSize: 14);
const TextStyle kBodyBold =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 14);
const TextStyle kButtonText =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 16);
const TextStyle kFootNote =
    TextStyle(fontWeight: FontWeight.normal, fontSize: 11);

///----AppBar Style----///

AppBarTheme appBarTheme = const AppBarTheme(
  backgroundColor: Colors.transparent,
  foregroundColor: Colors.transparent,
  elevation: 0,
);

///----------Text Form Field styles ---------////

InputDecoration camTextFieldDecoration = InputDecoration(
  errorStyle: kBody.copyWith(color: kFuchsia),
  errorBorder: OutlineInputBorder(
    gapPadding: 4,
    borderSide: const BorderSide(color: kFuchsia, width: 1),
    borderRadius: BorderRadius.circular(kDefaultPadding),
  ),
  border: OutlineInputBorder(
    gapPadding: 0,
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(kDefaultPadding),
  ),
  //isDense: false,
  filled: true,
  hintStyle: kBody,
  fillColor: kLightBlue,
);

///-------DateTime Constants -------////
///
Map<int, String> monthsOfYear = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December",
};
