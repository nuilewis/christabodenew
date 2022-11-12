import 'package:christabodenew/repositories/prayer_repository.dart';
import 'package:christabodenew/services/prayer/prayer_firestore_service.dart';
import 'package:christabodenew/services/prayer/prayer_hive_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'prayer_repository_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<PrayerHiveService>(), MockSpec<PrayerFireStoreService>()])
void main() {
  late PrayerRepository prayerRepository;
  late MockPrayerHiveService mockPrayerHiveService;
  late MockPrayerFireStoreService mockPrayerFirestoreService;
  setUp(() {
    mockPrayerHiveService = MockPrayerHiveService();
    mockPrayerFirestoreService = MockPrayerFireStoreService();
    prayerRepository = PrayerRepositoryImplementation(
        prayerHiveService: mockPrayerHiveService,
        prayerFirestoreService: mockPrayerFirestoreService);
  });

  test(
      "Should return a [List<Prayer>] object when [getPrayers] from FireStore is called successfully ]",
      () => null);
}
