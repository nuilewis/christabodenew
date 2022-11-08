import 'package:christabodenew/models/message_model.dart';
import 'package:dartz/dartz.dart';

import '../core/errors/failure.dart';

abstract class MessagesRepository{

  Future<Either<Failure, Message>> getMessage();

}


class MessagesRepositoryImplementation implements MessagesRepository{
  @override
  Future<Either<Failure, Message>> getMessage() {
    // TODO: implement getMessage
    throw UnimplementedError();
  }
 


}