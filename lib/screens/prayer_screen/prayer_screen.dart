import 'package:flutter/material.dart';


class PrayerScreen extends StatelessWidget {
  static const id = "prayer_screen.dart";
  static Route route(){return MaterialPageRoute(builder: (context)=>const PrayerScreen());}
  
  final bool isCalledFromNavBar;
  const PrayerScreen({super.key, this.isCalledFromNavBar=false});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}