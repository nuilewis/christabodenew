import 'package:christabodenew/screens/home_screen/home.dart';
import 'package:christabodenew/screens/hymn_screen/hymn_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
import 'devotional_screen/devotional_screen.dart';
import 'events_screen/events_screen.dart';
import 'prayer_screen/prayer_screen.dart';

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
      key: PageStorageKey(HymnScreen.id),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavBar(
      {required int selectedIndex, required Color selectedItemColor}) {
    return BottomNavigationBar(
      useLegacyColorScheme: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      type: BottomNavigationBarType.fixed,
      // landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      elevation: 0,
      enableFeedback: true,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedFontSize: 12,
      selectedFontSize: 12,
      selectedItemColor: selectedItemColor,
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          label: "Home",
          icon: SvgPicture.asset(
            "assets/svg/home_icon.svg",
            height: 23,
            color: Theme.of(context).iconTheme.color,
          ),
          activeIcon: SvgPicture.asset(
            "assets/svg/home_icon.svg",
            color: selectedItemColor,
            height: 23,
          ),
        ),
        BottomNavigationBarItem(
          label: "Devotional",
          icon: SvgPicture.asset(
            "assets/svg/read_icon.svg",
            height: 23,
            color: Theme.of(context).iconTheme.color,
          ),
          activeIcon: SvgPicture.asset(
            "assets/svg/read_icon.svg",
            color: selectedItemColor,
            height: 23,
          ),
        ),
        BottomNavigationBarItem(
          label: "Prayer",
          icon: SvgPicture.asset(
            "assets/svg/prayer_icon.svg",
            height: 24,
            color: Theme.of(context).iconTheme.color,
          ),
          activeIcon: SvgPicture.asset(
            "assets/svg/prayer_icon.svg",
            color: selectedItemColor,
            height: 24,
          ),
        ),
        BottomNavigationBarItem(
          label: "Events",
          icon: SvgPicture.asset(
            "assets/svg/notification_icon.svg",
            height: 23,
            color: Theme.of(context).iconTheme.color,
          ),
          activeIcon: SvgPicture.asset(
            "assets/svg/notification_icon.svg",
            color: selectedItemColor,
            height: 23,
          ),
        ),
        BottomNavigationBarItem(
          label: "Hymns",
          icon: SvgPicture.asset(
            "assets/svg/music_icon.svg",
            height: 23,
            color: Theme.of(context).iconTheme.color,
          ),
          activeIcon: SvgPicture.asset(
            "assets/svg/music_icon.svg",
            color: selectedItemColor,
            height: 23,
          ),
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
