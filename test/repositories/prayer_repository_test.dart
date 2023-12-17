import 'package:christabodenew/models/prayer_model.dart';
import 'package:christabodenew/repositories/prayer_repository.dart';
import 'package:christabodenew/services/prayer/prayer_firestore_service.dart';
import 'package:christabodenew/services/prayer/prayer_hive_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'prayer_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PrayerHiveService>(),
  MockSpec<PrayerFireStoreService>(),

])
void main() {
  late PrayerRepository prayerRepository;
  late MockPrayerHiveService mockPrayerHiveService;
  late MockPrayerFireStoreService mockPrayerFirestoreService;

  List<Prayer> returnedPrayer = Prayer.demoData;





  setUp(() {
    mockPrayerHiveService = MockPrayerHiveService();
    mockPrayerFirestoreService = MockPrayerFireStoreService();
    prayerRepository = PrayerRepository(
      prayerHiveService: mockPrayerHiveService,
      prayerFirestoreService: mockPrayerFirestoreService,
    );
  });


    test(
        "Should return Right[List<Prayer>] when get prayers from Firebase is called succesfully",
        () {});





}
