import 'package:christabodenew/screens/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'devotional_screen/devotional_screen.dart';
import 'events_screen/events_screen.dart';
import 'prayer_screen/prayer_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

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
    const EventsScreen(key: PageStorageKey(EventsScreen.id)),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavBar(int selectedIndex) {
    return BottomNavigationBar(
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
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        selectedItemColor: Theme.of(context).primaryColor,
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
              color: Theme.of(context).primaryColor,
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
              color: Theme.of(context).primaryColor,
              height: 23,
            ),
          ),
          BottomNavigationBarItem(
            label: "Prayer",
            icon: SvgPicture.asset("assets/svg/prayer_icon.svg",
                height: 24, color: Theme.of(context).iconTheme.color),
            activeIcon: SvgPicture.asset(
              "assets/svg/prayer_icon.svg",
              color: Theme.of(context).primaryColor,
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
              color: Theme.of(context).primaryColor,
              height: 23,
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(_selectedIndex),
      body: PageStorage(
        bucket: bucket,
        child: pages[_selectedIndex],
      ),
    );
  }
}
