import 'package:christabodenew/repositories/messages_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/errors/failure.dart';
import '../models/message_model.dart';

enum MessageState { initial, submitting, success, error }

class MessagesProvider extends ChangeNotifier {
  final MessagesRepository messageRepository;
  Message? message;
  String errorMessage = "";
  MessageState state = MessageState.initial;

  MessagesProvider(this.messageRepository);

  Future<void> getMessage() async {
    if (state == MessageState.submitting) return;
    state = MessageState.submitting;
    notifyListeners();
    Either<Failure, Message> response = await messageRepository.getMessage();

    response.fold((failure) {
      errorMessage =
          failure.errorMessage ?? "An error occurred while getting the message";
      state = MessageState.error;
    }, (msg) {
      state = MessageState.success;
      message = msg;
    });

    notifyListeners();
  }
}
