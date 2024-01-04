import 'package:christabodenew/core/constants.dart';
import 'package:christabodenew/screens/home_screen/home.dart';
import 'package:christabodenew/screens/hymn_screen/hymn_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/settings_provider.dart';
import '../devotional_screen/devotional_screen.dart';
import '../events_screen/events_screen.dart';
import '../prayer_screen/prayer_screen.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> pages = [
    const HomeScreen(
      key: PageStorageKey(HomeScreen.id),
    ),
    const DevotionalScreen(
      isCalledFromNavBar: true,
      key: PageStorageKey(DevotionalScreen.id),
    ),
    const PrayerScreen(
      isCalledFromNavBar: true,
      key: PageStorageKey(PrayerScreen.id),
    ),
    const EventsScreen(
      key: PageStorageKey(EventsScreen.id),
    ),
   const HymnScreen(
     isCalledFromNavBar: true,
      key: PageStorageKey(HymnScreen.id),

    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavBar(
      {required int selectedIndex, required Color selectedItemColor}) {
    return NavigationBar(

     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      indicatorColor: Theme.of(context).cardColor,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      elevation: 0,

      selectedIndex: selectedIndex,
      destinations: [
        NavigationDestination(
          label: "Home",
          icon: const Icon(FluentIcons.home_24_regular, color: AppColours.neutral50),
          selectedIcon: Icon(FluentIcons.home_24_filled, color: Theme.of(context).iconTheme.color,),
        ),
        NavigationDestination(
          label: "Devotional",
          selectedIcon: Icon(FluentIcons.reading_mode_mobile_24_filled, color: Theme.of(context).iconTheme.color),
          icon: const Icon(FluentIcons.reading_mode_mobile_24_regular,color: AppColours.neutral50),
        ),
        NavigationDestination(
          label: "Prayer",
          selectedIcon: SvgPicture.asset(
    "assets/svg/prayer_filled.svg",
    height: 24,
    colorFilter: ColorFilter.mode(Theme.of(context).iconTheme.color!, BlendMode.srcIn),
    ),
          icon: SvgPicture.asset(
            "assets/svg/prayer.svg",
            height: 24,
            colorFilter: const ColorFilter.mode(AppColours.neutral50, BlendMode.srcIn),
          ),

        ),
        NavigationDestination(
          label: "Events",
          icon: const Icon(FluentIcons.alert_24_regular, color: AppColours.neutral50),
          selectedIcon: Icon(FluentIcons.alert_24_filled, color: Theme.of(context).iconTheme.color ),

        ),
        NavigationDestination(
          label: "Hymns",
          icon: const Icon(FluentIcons.music_note_1_24_regular, color: AppColours.neutral50),
          selectedIcon: Icon(FluentIcons.music_note_1_24_filled, color: Theme.of(context).iconTheme.color),


        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsData, child) {
        return Scaffold(
          bottomNavigationBar: _bottomNavBar(
              selectedIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Theme.of(context).primaryColor),
          body: PageStorage(
            bucket: bucket,
            child: pages[_selectedIndex],
          ),
        );
      },
    );
  }
}
