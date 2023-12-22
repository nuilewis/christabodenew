import 'package:christabodenew/firebase_options.dart';
import 'package:christabodenew/repositories/events_repository.dart';
import 'package:christabodenew/screens/global_components/bottom_nav_bar.dart';
import 'package:christabodenew/screens/devotional_screen/devotional_screen.dart';
import 'package:christabodenew/screens/events_screen/events_screen.dart';
import 'package:christabodenew/screens/favourite_screen/favourites_screen.dart';
import 'package:christabodenew/screens/hymn_screen/hymn_screen.dart';
import 'package:christabodenew/screens/hymn_screen/hymn_screen_details.dart';
import 'package:christabodenew/screens/messages_screen/messages_screen.dart';
import 'package:christabodenew/screens/prayer_screen/prayer_screen.dart';
import 'package:christabodenew/services/events/event_hive_service.dart';
import 'package:christabodenew/services/events/events_firestore_service.dart';
import 'package:christabodenew/services/unsplash/unsplash_hive_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repositories/repositories.dart';
import 'providers/providers.dart';
import 'services/services.dart';
import 'core/core.dart';

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

  late PrayerRepository _prayerRepository;

  ///Creating and Injecting Devotional Dependencies
  final DevotionalFirestoreService _devotionalFirestoreService =
      DevotionalFirestoreService();
  final DevotionalHiveService _devotionalHiveService = DevotionalHiveService();
  late DevotionalRepository _devotionalRepository;

  ///Creating and Injecting Events Dependencies
  final EventsFirestoreService _eventsFirestoreService =
      EventsFirestoreService();
  final EventsHiveService _eventsHiveService = EventsHiveService();
  late EventsRepository _eventsRepository;

  ///Creating and Injecting Unsplash Image Dependencies
  late UnsplashImageRepository _unsplashImageRepository;
  final UnsplashAPIClient _unsplashAPIClient = UnsplashAPIClient();
  final UnsplashHiveService _unsplashHiveService = UnsplashHiveService();

  ///Creating and Injecting Settings Dependencies
  late SettingsRepository _settingsRepository;
  final SettingsHiveService _settingsHiveService = SettingsHiveService();

  ///Creating and Injectig Hymns Depedecies

  late HymnRepository _hymnRepository;
  final HymnHiveService _hymnHiveService = HymnHiveService();
  final HymnFireStoreService _hymnFireStoreService = HymnFireStoreService();

  @override
  void initState() {
    _prayerRepository = PrayerRepository(
      prayerHiveService: _prayerHiveService,
      prayerFirestoreService: _prayerFireStoreService,
    );

    _devotionalRepository = DevotionalRepository(
      devotionalFirestoreService: _devotionalFirestoreService,
      devotionalHiveService: _devotionalHiveService,
    );

    _eventsRepository = EventsRepository(
      eventsFirestoreService: _eventsFirestoreService,
      eventsHiveService: _eventsHiveService,
    );

    _unsplashImageRepository = UnsplashImageRepository(
      unsplashHiveService: _unsplashHiveService,
      apiClient: _unsplashAPIClient,
    );

    _settingsRepository = SettingsRepository(_settingsHiveService);

    _hymnRepository = HymnRepository(
        hymnHiveService: _hymnHiveService,
        hymnFirestoreService: _hymnFireStoreService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsProvider>(
            create: (context) =>
                SettingsProvider(_settingsRepository)..getSettings()),
        ChangeNotifierProvider<PrayerProvider>(
            create: (context) =>
                PrayerProvider(prayerRepository: _prayerRepository)
                  ..initialise()),
        ChangeNotifierProvider<DevotionalProvider>(
            create: (context) => DevotionalProvider(_devotionalRepository)
              ..initialise(devotionalYear: "2024")),
        ChangeNotifierProvider<EventsProvider>(
            create: (context) =>
                EventsProvider(eventsRepository: _eventsRepository)
                  ..initialise(eventsYear: "2024")),
        ChangeNotifierProvider<UnsplashImageProvider>(
            create: (context) => UnsplashImageProvider(
                unsplashImageRepository: _unsplashImageRepository)..getFeaturedImages()
              ),
        ChangeNotifierProvider<HymnProvider>(
            create: (context) =>
                HymnProvider(hymnRepository: _hymnRepository)..initialise())
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Christ Abode Ministries',
          theme: AppThemeData.lightTheme,
          darkTheme: AppThemeData.darkTheme,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: const BottomNavBar(),
          routes: {
            HomeScreen.id: (context) => const HomeScreen(),
            DevotionalScreen.id: (context) => const DevotionalScreen(),
            PrayerScreen.id: (context) => const PrayerScreen(),
            EventsScreen.id: (context) => const EventsScreen(),
            MessagesScreen.id: (context) => const MessagesScreen(),
            FavouritesScreen.id: (context) => const FavouritesScreen(),
            HymnScreen.id: (context) => const HymnScreen(),
            HymnScreenDetails.id: (context) => const HymnScreenDetails()
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
