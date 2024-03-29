import 'package:christabodenew/core/core.dart';
import 'package:christabodenew/models/devotional_model.dart';
import 'package:christabodenew/providers/devotional_provider.dart';
import 'package:christabodenew/repositories/devotional_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'devotional_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DevotionalRepository>()])
void main() {
  late DevotionalProvider devotionalProvider;
  late MockDevotionalRepository mockDevotionalRepository;

  final Devotional returnedDevotional = Devotional(
      title: "title",
      scripture: "scripture",
      scriptureReference: "scriptureReference",
      confessionOfFaith: "confessionOfFaith",
      author: "author",
      content: "content",
      startDate: DateTime.now(),
      endDate: DateTime.now());

  final List<Devotional> returnedDevotionalList = [
    Devotional(
        title: "title 1",
        scripture: "scripture 1",
        scriptureReference: "scriptureReference 1",
        confessionOfFaith: "confessionOfFaith",
        author: "author",
        content: "content",
        startDate: DateTime.now(),
        endDate: DateTime.now()),
    Devotional(
        title: "title 2",
        scripture: "scripture 2",
        scriptureReference: "scriptureReference 2",
        confessionOfFaith: "confessionOfFaith",
        author: "author",
        content: "content",
        startDate: DateTime.now(),
        endDate: DateTime.now()),
  ];

  setUp(() {
    mockDevotionalRepository = MockDevotionalRepository();
    devotionalProvider = DevotionalProvider(mockDevotionalRepository);
  });

  test("verify initial values of Devotional provider", () {
    expect(devotionalProvider.errorMessage, "");
    expect(devotionalProvider.state, AppState.initial);
    expect(devotionalProvider.todaysDevotional, null);
  });

  group("Test [GetDevotional]", () {
    test(
        "Should return a [Devotional] obj and set the state to success when [getDevotional] is called successfully from the repository",
        () async {
      //arrange
      when(mockDevotionalRepository.getDevotionals())
          .thenAnswer((_) async => Right(returnedDevotionalList));

      //act
      await devotionalProvider.getDevotionals();

      //assert
      expect(devotionalProvider.allDevotionals, returnedDevotionalList);
      expect(devotionalProvider.state, AppState.success);

      verify(mockDevotionalRepository.getDevotionals()).called(1);
      verifyNoMoreInteractions(mockDevotionalRepository);
    });

    test(
        "Should return a [Failure] obj and set the state to success when [getDevotional] is called un successfully from the repository",
        () async {
      //arrange
      when(mockDevotionalRepository.getDevotionals()).thenAnswer((_) async =>
          Future.value(
              const Left(Failure(errorMessage: "error message"))));

      //act

      await devotionalProvider.getDevotionals();

      //assert
      expect(devotionalProvider.todaysDevotional, null);
      expect(devotionalProvider.errorMessage, "error message");
      expect(devotionalProvider.state, AppState.error);

      verify(mockDevotionalRepository.getDevotionals()).called(1);
      verifyNoMoreInteractions(mockDevotionalRepository);
    });
  });
  group("Test [GetCurrentDevotional]", () {
    test(
        "Should return a [Devotional] obj and set the state to success when [getCurrentDevotional] is called successfully from the repository",
        () async {
      //arrange
      when(mockDevotionalRepository.getCurrentDevotional())
          .thenAnswer((_) async => Right(returnedDevotional));

      //act
      await devotionalProvider.getCurrentDevotional();

      //assert
      expect(devotionalProvider.todaysDevotional, returnedDevotional);
      expect(devotionalProvider.state, AppState.success);

      verify(mockDevotionalRepository.getCurrentDevotional()).called(1);
      verifyNoMoreInteractions(mockDevotionalRepository);
    });

    test(
        "Should return a [Failure] obj and set the state to success when [getCurrentDevotional] is called un successfully from the repository",
        () async {
      //arrange
      when(mockDevotionalRepository.getCurrentDevotional()).thenAnswer(
          (_) async => Future.value(
              const Left(Failure(errorMessage: "error message"))));

      //act

      await devotionalProvider.getCurrentDevotional();

      //assert
      expect(devotionalProvider.todaysDevotional, null);
      expect(devotionalProvider.errorMessage, "error message");
      expect(devotionalProvider.state, AppState.error);

      verify(mockDevotionalRepository.getCurrentDevotional()).called(1);
      verifyNoMoreInteractions(mockDevotionalRepository);
    });
  });
}
