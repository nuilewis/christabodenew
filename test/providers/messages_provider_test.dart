import 'package:christabodenew/core/core.dart';
import 'package:christabodenew/models/message_model.dart';
import 'package:christabodenew/providers/messages_provider.dart';
import 'package:christabodenew/repositories/messages_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'messages_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MessagesRepository>()])
void main() {
  late MessagesProvider messagesProvider;
  late MockMessagesRepository mockMessagesRepository;

  const Message returnedMessage =
      Message(title: "title", content: "content", author: "author");

  setUp(() {
    mockMessagesRepository = MockMessagesRepository();
    messagesProvider = MessagesProvider(mockMessagesRepository);
  });

  group("Test [getMessages]", () {
    test(
        "Should return a [Messages] obj and set the state to success when [getMessages] is called successfully from the repository",
        () async {
      //arrange
      when(mockMessagesRepository.getMessage())
          .thenAnswer((_) async => const Right(returnedMessage));

      //act
      await messagesProvider.getMessage();

      //assert
      expect(messagesProvider.message, returnedMessage);
      expect(messagesProvider.state, AppState.success);

      verify(mockMessagesRepository.getMessage()).called(1);
      verifyNoMoreInteractions(mockMessagesRepository);
    });

    test(
        "Should return a [Failure] obj and set the state to success when [getMessages] is called un successfully from the repository",
        () async {
      when(mockMessagesRepository.getMessage()).thenAnswer((_) async =>
          const Left(Failure(errorMessage: "error message")));

      //act
      await messagesProvider.getMessage();

      //assert
      expect(messagesProvider.message, null);
      expect(messagesProvider.errorMessage, "error message");
      expect(messagesProvider.state, AppState.error);

      verify(mockMessagesRepository.getMessage()).called(1);
      verifyNoMoreInteractions(mockMessagesRepository);
    });
  });
}
