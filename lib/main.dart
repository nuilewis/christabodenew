import 'package:christabodenew/core/connection_checker/connection_checker.dart';
import 'package:christabodenew/firebase_options.dart';
import 'package:christabodenew/providers/devotional_provider.dart';
import 'package:christabodenew/providers/messages_provider.dart';
import 'package:christabodenew/providers/prayer_provider.dart';
import 'package:christabodenew/providers/settings_provider.dart';
import 'package:christabodenew/providers/unsplash_image_provider.dart';
import 'package:christabodenew/repositories/devotional_repository.dart';
import 'package:christabodenew/repositories/events_repository.dart';
import 'package:christabodenew/repositories/messages_repository.dart';
import 'package:christabodenew/repositories/prayer_repository.dart';
import 'package:christabodenew/repositories/settings_repository.dart';
import 'package:christabodenew/screens/bottom_nav_bar.dart';
import 'package:christabodenew/screens/devotional_screen/devotional_screen.dart';
import 'package:christabodenew/screens/events_screen/events_screen.dart';
import 'package:christabodenew/screens/favourite_screen/favourites_screen.dart';
import 'package:christabodenew/screens/messages_screen/messages_screen.dart';
import 'package:christabodenew/screens/prayer_screen/prayer_screen.dart';
import 'package:christabodenew/services/devotional/devotional_firestore_service.dart';
import 'package:christabodenew/services/devotional/devotional_hive_service.dart';
import 'package:christabodenew/services/events/event_hive_service.dart';
import 'package:christabodenew/services/events/events_firestore_service.dart';
import 'package:christabodenew/services/hive_base_service.dart';
import 'package:christabodenew/services/prayer/prayer_firestore_service.dart';
import 'package:christabodenew/services/prayer/prayer_hive_service.dart';
import 'package:christabodenew/services/settings/settings_hive_service.dart';
import 'package:christabodenew/services/unsplash/unsplash_api_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'core/theme.dart';
import 'providers/events_provider.dart';
import 'repositories/unsplash_image_repository.dart';
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

  ///Creating and Injecting Events Dependencies
  final EventsFirestoreService _eventsFirestoreService =
      EventsFirestoreService();
  final EventsHiveService _eventsHiveService = EventsHiveService();
  late EventsRepository _eventsRepository;

  ///Creating and Injecting Unsplash Image Dependencies
  late UnsplashImageRepository _unsplashImageRepository;
  final UnsplashAPIClient _unsplashAPIClient = UnsplashAPIClient();

  ///Creating and Injecting Settings Dependencies
  late SettingsRepository _settingsRepository;
  final SettingsHiveService _settingsHiveService = SettingsHiveService();

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

    _eventsRepository = EventsRepositoryImplementation(
        eventsFirestoreService: _eventsFirestoreService,
        eventsHiveService: _eventsHiveService,
        connectionChecker: _connectionChecker);

    _unsplashImageRepository = UnsplashImageRepositoryImplementation(
        apiClient: _unsplashAPIClient, connectionChecker: _connectionChecker);

    _settingsRepository =
        SettingsRepositoryImplementation(_settingsHiveService);
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
                DevotionalProvider(_devotionalRepository)..initStuff()),
        ChangeNotifierProvider<MessagesProvider>(
            create: (context) => MessagesProvider(_messagesRepository)),
        ChangeNotifierProvider<EventsProvider>(
            create: (context) =>
                EventsProvider(eventsRepository: _eventsRepository)
                  ..getEvents()),
        ChangeNotifierProvider<UnsplashImageProvider>(
            create: (context) => UnsplashImageProvider(
                unsplashImageRepository: _unsplashImageRepository)
              ..getRandomImage()),
        ChangeNotifierProvider<SettingsProvider>(
            create: (context) =>
                SettingsProvider(_settingsRepository)..getSettings())
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Christ Abode Ministries',
          theme: lightThemeData(context),
          darkTheme: darkThemeData(context),
          themeMode:
              Provider.of<SettingsProvider>(context).userSettings.isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const BottomNavBar(),
          routes: {
            HomeScreen.id: (context) => const HomeScreen(),
            DevotionalScreen.id: (context) => const DevotionalScreen(),
            PrayerScreen.id: (context) => const PrayerScreen(),
            EventsScreen.id: (context) => const EventsScreen(),
            MessagesScreen.id: (context) => const MessagesScreen(),
            FavouritesScreen.id: (context) => const FavouritesScreen(),
          },
        );
      }),
    );
  }
}

Future<void> initialiseHive() async {
  final HiveService mainHiveService = HiveService();
  await mainHiveService.initHive();
}
