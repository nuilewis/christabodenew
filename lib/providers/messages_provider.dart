import 'package:christabodenew/repositories/messages_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/errors/failure.dart';
import '../models/message_model.dart';

enum MessageStatus{initial, submitting, success, error}
class MessagesProvider extends ChangeNotifier{

final MessagesRepository messageRepository;
Message? message;
String errorMessage ="";
MessageStatus status = MessageStatus.initial;

  MessagesProvider(this.messageRepository);


Future<void> getMessage()async {
  if (status == MessageStatus.submitting) return;

  Either<Failure, Message> response = await messageRepository.getMessage();

  response.fold((failure) {
    errorMessage = failure.errorMessage??"An error occured while getting the message";
    status = MessageStatus.error;
    notifyListeners();
  }, (msg){
    status = MessageStatus.success;
    message = msg;
    notifyListeners();
  });
}
  

}