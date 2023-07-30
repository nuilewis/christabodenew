import 'package:christabodenew/core/connection_checker/connection_checker.dart';
import 'package:christabodenew/models/prayer_model.dart';
import 'package:christabodenew/repositories/prayer_repository.dart';
import 'package:christabodenew/services/prayer/prayer_firestore_service.dart';
import 'package:christabodenew/services/prayer/prayer_hive_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'prayer_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PrayerHiveService>(),
  MockSpec<PrayerFireStoreService>(),
  MockSpec<ConnectionChecker>()
])
void main() {
  late PrayerRepository prayerRepository;
  late MockPrayerHiveService mockPrayerHiveService;
  late MockPrayerFireStoreService mockPrayerFirestoreService;
  late MockConnectionChecker mockConnectionChecker;

  List<Prayer> returnedPrayer = Prayer.demoData;

  void runTestsOnline(Function body) {
    group("Tests When Device is online", () {
      setUp(() {
        when(mockConnectionChecker.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group("Tests When Device is offline", () {
      setUp(() {
        when(mockConnectionChecker.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  setUp(() {
    mockPrayerHiveService = MockPrayerHiveService();
    mockPrayerFirestoreService = MockPrayerFireStoreService();
    mockConnectionChecker = MockConnectionChecker();
    prayerRepository = PrayerRepository(
      prayerHiveService: mockPrayerHiveService,
      prayerFirestoreService: mockPrayerFirestoreService,
      connectionChecker: mockConnectionChecker,
    );
  });

  runTestsOnline(() {
    test(
        "Should return Right[List<Prayer>] when get prayers from Firebase is called succesfully",
        () {});
  });

  runTestsOffline(() {
    test(
        "Should return Left[NetworkFailure] when get prayers from Firebase is called and the device is offline",
        () {});
  });
}
