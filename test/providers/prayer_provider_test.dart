import 'package:christabodenew/core/core.dart';
import 'package:christabodenew/models/prayer_model.dart';
import 'package:christabodenew/providers/prayer_provider.dart';
import 'package:christabodenew/repositories/prayer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'prayer_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PrayerRepository>()])
void main() {
  late PrayerProvider prayerProvider;
  late MockPrayerRepository mockPrayerRepository;
  final Prayer returnedPrayer = Prayer(
      title: "prayerTitle",
      scripture: "scripture",
      scriptureReference: "scriptureReference",
      content: "prayerMessage",
      date: DateTime.now());

  final List<Prayer> returnedPrayerList = Prayer.demoData;

  setUp(() {
    mockPrayerRepository = MockPrayerRepository();
    prayerProvider = PrayerProvider(prayerRepository: mockPrayerRepository);
  });

  test("Verify initial values of the Prayer Provider", () {
    expect(prayerProvider.state, AppState.initial);
    expect(prayerProvider.errorMessage, "");
    expect(prayerProvider.todaysPrayer, null);
    expect(prayerProvider.allPrayers, []);
  });

  group("Test [getPrayer]", () {
    test(
        "Should return a [Prayer] obj and set the state to success when [getPrayer] is called successfully from the repository",
        () async {
      //arrange
      when(mockPrayerRepository.getPrayers())
          .thenAnswer((_) async => Right(returnedPrayerList));

      //act
      await prayerProvider.getPrayers();

      //assert
      expect(prayerProvider.allPrayers, returnedPrayerList);
      expect(prayerProvider.state, AppState.success);

      verify(mockPrayerRepository.getPrayers()).called(1);
      verifyNoMoreInteractions(mockPrayerRepository);
    });

    test(
        "Should return a [Failure] obj and set the state to success when [getPrayer] is called un successfully from the repository",
        () async {
      //arrange
      when(mockPrayerRepository.getPrayers()).thenAnswer((_) async =>
          Future.value(
              const Left(Failure(errorMessage: "error message"))));

      //act

      await prayerProvider.getPrayers();

      //assert
      expect(prayerProvider.state, AppState.error);
      expect(prayerProvider.todaysPrayer, null);
      expect(prayerProvider.errorMessage, "error message");

      verify(mockPrayerRepository.getPrayers()).called(1);
      verifyNoMoreInteractions(mockPrayerRepository);
    });
  });
  group("Test [getCurrentPrayer]", () {
    test(
        "Should return a [Prayer] obj and set the state to success when [getCurrentPrayer] is called successfully from the repository",
        () async {
      //arrange
      when(mockPrayerRepository.getCurrentPrayer())
          .thenAnswer((_) async => Right(returnedPrayer));

      //act
      await prayerProvider.getCurrentPrayer();

      //assert
      expect(prayerProvider.todaysPrayer, returnedPrayer);
      expect(prayerProvider.state, AppState.success);

      verify(mockPrayerRepository.getCurrentPrayer()).called(1);
      verifyNoMoreInteractions(mockPrayerRepository);
    });

    test(
        "Should return a [Failure] obj and set the state to success when [getCurrentPrayer] is called un successfully from the repository",
        () async {
      //arrange
      when(mockPrayerRepository.getCurrentPrayer()).thenAnswer((_) async =>
          Future.value(
              const Left(Failure(errorMessage: "error message"))));

      //act

      await prayerProvider.getCurrentPrayer();

      //assert
      expect(prayerProvider.state, AppState.error);
      expect(prayerProvider.todaysPrayer, null);
      expect(prayerProvider.errorMessage, "error message");

      verify(mockPrayerRepository.getCurrentPrayer()).called(1);
      verifyNoMoreInteractions(mockPrayerRepository);
    });
  });
}
