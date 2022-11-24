import 'package:christabodenew/firebase_options.dart';
import 'package:christabodenew/screens/bottom_nav_bar.dart';
import 'package:christabodenew/screens/devotional_screen/devotional_screen.dart';
import 'package:christabodenew/screens/events_screen/events_screen.dart';
import 'package:christabodenew/screens/messages_screen/messages_screen.dart';
import 'package:christabodenew/screens/prayer_screen/prayer_screen.dart';
import 'package:christabodenew/services/devotional/devotional_hive_service.dart';
import 'package:christabodenew/services/messages/messages_hive_service.dart';
import 'package:christabodenew/services/prayer/prayer_hive_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'screens/home_screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initialiseHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Christ Abode Ministries',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.dark,
      home: const BottomNavBar(),
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        DevotionalScreen.id: (context) => const DevotionalScreen(),
        PrayerScreen.id: (context) => const PrayerScreen(),
        EventsScreen.id: (context) => const EventsScreen(),
        MessagesScreen.id: (context) => const MessagesScreen(),
      },
    );
  }
}

Future<void> initialiseHive() async {
  final PrayerHiveService prayerHiveService = PrayerHiveService();
  final DevotionalHiveService devotionalHiveService = DevotionalHiveService();
  final MessagesHiveService messagesHiveService = MessagesHiveService();

  await prayerHiveService.initHive();
  await devotionalHiveService.initHive();
  await messagesHiveService.initHive();
}
