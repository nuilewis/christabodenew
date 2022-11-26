import 'package:christabodenew/core/connection_checker/connection_checker.dart';
import 'package:christabodenew/firebase_options.dart';
import 'package:christabodenew/providers/devotional_provider.dart';
import 'package:christabodenew/providers/messages_provider.dart';
import 'package:christabodenew/providers/prayer_provider.dart';
import 'package:christabodenew/repositories/devotional_repository.dart';
import 'package:christabodenew/repositories/messages_repository.dart';
import 'package:christabodenew/repositories/prayer_repository.dart';
import 'package:christabodenew/screens/bottom_nav_bar.dart';
import 'package:christabodenew/screens/devotional_screen/devotional_screen.dart';
import 'package:christabodenew/screens/events_screen/events_screen.dart';
import 'package:christabodenew/screens/messages_screen/messages_screen.dart';
import 'package:christabodenew/screens/prayer_screen/prayer_screen.dart';
import 'package:christabodenew/services/devotional/devotional_firestore_service.dart';
import 'package:christabodenew/services/devotional/devotional_hive_service.dart';
import 'package:christabodenew/services/messages/messages_hive_service.dart';
import 'package:christabodenew/services/prayer/prayer_firestore_service.dart';
import 'package:christabodenew/services/prayer/prayer_hive_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'core/theme.dart';
import 'screens/home_screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initialiseHive();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  ///Creating and Injecting Prayer Dependencies
  final PrayerHiveService _prayerHiveService = PrayerHiveService();

  final PrayerFireStoreService _prayerFireStoreService =
      PrayerFireStoreService();
  final ConnectionChecker _connectionChecker =
      ConnectionCheckerImplementation(InternetConnectionChecker());
  late PrayerRepository _prayerRepository;

  ///Creating and Injecting Devotional Dependencies
  final DevotionalFirestoreService _devotionalFirestoreService =
      DevotionalFirestoreService();
  final DevotionalHiveService _devotionalHiveService = DevotionalHiveService();
  late DevotionalRepository _devotionalRepository;

  ///Creating and Injecting Messages Dependencies
  late MessagesRepository _messagesRepository;

  @override
  void initState() {
    _prayerRepository = PrayerRepositoryImplementation(
        prayerHiveService: _prayerHiveService,
        prayerFirestoreService: _prayerFireStoreService,
        connectionChecker: _connectionChecker);

    _devotionalRepository = DevotionalRepositoryImplementation(
        devotionalFirestoreService: _devotionalFirestoreService,
        devotionalHiveService: _devotionalHiveService,
        connectionChecker: _connectionChecker);

    _messagesRepository = MessagesRepositoryImplementation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PrayerProvider>(
            create: (context) =>
                PrayerProvider(prayerRepository: _prayerRepository)
                  ..getPrayer()),
        ChangeNotifierProvider<DevotionalProvider>(
            create: (context) =>
                DevotionalProvider(_devotionalRepository)..getDevotional()),
        ChangeNotifierProvider<MessagesProvider>(
            create: (context) =>
                MessagesProvider(_messagesRepository)..getMessage())
      ],
      child: MaterialApp(
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
      ),
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
