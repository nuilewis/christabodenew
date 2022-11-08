import 'package:dartz/dartz.dart';

import '../core/errors/failure.dart';
import '../models/prayer_model.dart';

abstract class PrayerRepository{

  Future<Either<Failure, Prayer>> getCurrentPrayer();
  Future<Either<Failure, Prayer>> getNextPrayer();
  Future<Either<Failure, Prayer>> getPreviousPrayer();
  Future<Either<Failure, Prayer>> getPrayer();
}


class PrayerRepositoryImplementation implements PrayerRepository{
  @override
  Future<Either<Failure, Prayer>> getCurrentPrayer() {
    // TODO: implement getCurrentPrayer
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Prayer>> getNextPrayer() {
    // TODO: implement getNextPrayer
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Prayer>> getPrayer() {
    // TODO: implement getPrayer
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Prayer>> getPreviousPrayer() {
    // TODO: implement getPreviousPrayer
    throw UnimplementedError();
  }


}