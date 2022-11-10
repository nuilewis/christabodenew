import 'package:christabodenew/core/errors/failure.dart';
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
      message: "prayerMessage",
      date: DateTime.now());

  setUp(() {
    mockPrayerRepository = MockPrayerRepository();
    prayerProvider = PrayerProvider(prayerRepository: mockPrayerRepository);
  });

  test("Verify initial values of the Prayer Provider", () {
    expect(prayerProvider.state, PrayerState.initial);
    expect(prayerProvider.errorMessage, "");
    expect(prayerProvider.todaysPrayer, null);
  });

  group("Test [getPrayer]", () {
    test(
        "Should return a [Prayer] obj and set the state to success when [getPrayer] is called successfully from the repository",
        () async {
      //arrange
      when(mockPrayerRepository.getPrayer())
          .thenAnswer((_) async => Right(returnedPrayer));

      //act
      await prayerProvider.getPrayer();

      //assert
      expect(prayerProvider.todaysPrayer, returnedPrayer);
      expect(prayerProvider.state, PrayerState.success);

      verify(mockPrayerRepository.getPrayer()).called(1);
      verifyNoMoreInteractions(mockPrayerRepository);
    });

    test(
        "Should return a [Failure] obj and set the state to success when [getPrayer] is called un successfully from the repository",
        () async {
      //arrange
      when(mockPrayerRepository.getPrayer()).thenAnswer((_) async =>
          Future.value(const Left(Failure(errorMessage: "error message"))));

      //act

      await prayerProvider.getPrayer();

      //assert
      expect(prayerProvider.state, PrayerState.error);
      expect(prayerProvider.todaysPrayer, null);
      expect(prayerProvider.errorMessage, "error message");

      verify(mockPrayerRepository.getPrayer()).called(1);
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
      expect(prayerProvider.state, PrayerState.success);

      verify(mockPrayerRepository.getCurrentPrayer()).called(1);
      verifyNoMoreInteractions(mockPrayerRepository);
    });

    test(
        "Should return a [Failure] obj and set the state to success when [getCurrentPrayer] is called un successfully from the repository",
        () async {
      //arrange
      when(mockPrayerRepository.getCurrentPrayer()).thenAnswer((_) async =>
          Future.value(const Left(Failure(errorMessage: "error message"))));

      //act

      await prayerProvider.getCurrentPrayer();

      //assert
      expect(prayerProvider.state, PrayerState.error);
      expect(prayerProvider.todaysPrayer, null);
      expect(prayerProvider.errorMessage, "error message");

      verify(mockPrayerRepository.getCurrentPrayer()).called(1);
      verifyNoMoreInteractions(mockPrayerRepository);
    });
  });
  group("Test [getNextPrayer]", () {
    test(
        "Should return a [Prayer] obj and set the state to success when [getNextPrayer] is called successfully from the repository",
        () async {
      //arrange
      when(mockPrayerRepository.getNextPrayer())
          .thenAnswer((_) async => Right(returnedPrayer));

      //act
      await prayerProvider.getNextPrayer();

      //assert
      expect(prayerProvider.todaysPrayer, returnedPrayer);
      expect(prayerProvider.state, PrayerState.success);

      verify(mockPrayerRepository.getNextPrayer()).called(1);
      verifyNoMoreInteractions(mockPrayerRepository);
    });

    test(
        "Should return a [Failure] obj and set the state to success when [getNextPrayer] is called un successfully from the repository",
        () async {
      //arrange
      when(mockPrayerRepository.getNextPrayer()).thenAnswer((_) async =>
          Future.value(const Left(Failure(errorMessage: "error message"))));

      //act

      await prayerProvider.getNextPrayer();

      //assert
      expect(prayerProvider.state, PrayerState.error);
      expect(prayerProvider.todaysPrayer, null);
      expect(prayerProvider.errorMessage, "error message");

      verify(mockPrayerRepository.getNextPrayer()).called(1);
      verifyNoMoreInteractions(mockPrayerRepository);
    });
  });
  group("Test [getPreviousPrayer]", () {
    test(
        "Should return a [Prayer] obj and set the state to success when [getPreviousPrayer] is called successfully from the repository",
        () async {
      //arrange
      when(mockPrayerRepository.getPreviousPrayer())
          .thenAnswer((_) async => Right(returnedPrayer));

      //act
      await prayerProvider.getPreviousPrayer();

      //assert
      expect(prayerProvider.todaysPrayer, returnedPrayer);
      expect(prayerProvider.state, PrayerState.success);

      verify(mockPrayerRepository.getPreviousPrayer()).called(1);
      verifyNoMoreInteractions(mockPrayerRepository);
    });

    test(
        "Should return a [Failure] obj and set the state to success when [getPreviousPrayer] is called un successfully from the repository",
        () async {
      //arrange
      when(mockPrayerRepository.getPreviousPrayer()).thenAnswer((_) async =>
          Future.value(const Left(Failure(errorMessage: "error message"))));

      //act

      await prayerProvider.getPreviousPrayer();

      //assert
      expect(prayerProvider.state, PrayerState.error);
      expect(prayerProvider.todaysPrayer, null);
      expect(prayerProvider.errorMessage, "error message");

      verify(mockPrayerRepository.getPreviousPrayer()).called(1);
      verifyNoMoreInteractions(mockPrayerRepository);
    });
  });
}
