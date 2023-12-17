import 'package:christabodenew/repositories/messages_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/core.dart';
import '../models/message_model.dart';


class MessagesProvider extends ChangeNotifier {
  final MessagesRepository messageRepository;
  Message? message;
  String errorMessage = "";
  AppState state = AppState.initial;

  MessagesProvider(this.messageRepository);

  Future<void> getMessage() async {
    if (state == AppState.submitting) return;
    state = AppState.submitting;
    notifyListeners();
    Either<Failure, Message> response = await messageRepository.getMessage();

    response.fold((failure) {
      errorMessage =
          failure.errorMessage ?? "An error occurred while getting the message";
      state = AppState.error;
    }, (msg) {
      state = AppState.success;
      message = msg;
    });

    notifyListeners();
  }
}
