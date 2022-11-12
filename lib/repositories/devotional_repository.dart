import 'package:christabodenew/models/devotional_model.dart';
import 'package:dartz/dartz.dart';

import '../core/errors/failure.dart';

abstract class DevotionalRepository {
  Future<Either<Failure, Devotional>> getCurrentDevotional();
  Future<Either<Failure, Devotional>> getNextDevotional();
  Future<Either<Failure, Devotional>> getPreviousDevotional();
  Future<Either<Failure, Devotional>> getDevotional();
}

class DevotionalRepositoryImplementation implements DevotionalRepository {
  @override
  Future<Either<Failure, Devotional>> getCurrentDevotional() {
    // TODO: implement getCurrentDevotional
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Devotional>> getDevotional() {
    // TODO: implement getDevotional
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Devotional>> getNextDevotional() {
    // TODO: implement getNextDevotional
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Devotional>> getPreviousDevotional() {
    // TODO: implement getPreviousDevotional
    throw UnimplementedError();
  }
}
