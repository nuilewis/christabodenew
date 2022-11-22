import 'package:christabodenew/services/prayer/prayer_hive_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../core/connection_checker/connection_checker.dart';
import '../core/errors/failure.dart';
import '../models/prayer_model.dart';
import '../services/prayer/prayer_firestore_service.dart';

abstract class PrayerRepository {
  Future<Either<Failure, Prayer>> getCurrentPrayer();
  Future<Either<Failure, Prayer>> getNextPrayer();
  Future<Either<Failure, Prayer>> getPreviousPrayer();
  Future<Either<Failure, Prayer>> getPrayers();
}

class PrayerRepositoryImplementation implements PrayerRepository {
  final PrayerFireStoreService prayerFirestoreService;
  final PrayerHiveService prayerHiveService;
  final ConnectionChecker connectionChecker;
  PrayerRepositoryImplementation({
    required this.prayerHiveService,
    required this.prayerFirestoreService,
    required this.connectionChecker,
  });
  @override
  Future<Either<Failure, Prayer>> getPrayers() async {
    List<Prayer> prayerList = [];
    Prayer prayer = Prayer.empty;

    /// try to get from offline
    /// if offline is empty, then check for network connectivity, if network is not there, throw a network error
    /// if network is there, then try to get from offline.

    ///Todo: try to get prayer offline, if its, empty then  retry online.
    //prayerList = await prayerHiveService.getPrayer();
    if (prayerList.isEmpty) {
      if (await connectionChecker.isConnected) {
        try {
          QuerySnapshot querySnapshot =
              await prayerFirestoreService.getPrayers();

          if (querySnapshot.docs.isNotEmpty) {
            for (var element in querySnapshot.docs) {
              Map<String, dynamic> documentData =
                  element.data() as Map<String, dynamic>;
              String excerpt =
                  documentData["content"].toString().substring(0, 20);
              prayer = Prayer(
                title: documentData["title"],
                scripture: documentData["scripture"],
                scriptureReference: documentData["scriptureRef"],
                content: documentData["content"],
                date: documentData["start"],
                excerpt: excerpt,
              );

              prayerList.add(prayer);
            }
          }
          return Right(prayer);
        } on FirebaseException catch (e) {
          return Left(FirebaseFailure(errorMessage: e.message, code: e.code));
        }
      } else {
        return const Left(NetworkFailure());
      }
    } else {
      return const Left(FirebaseFailure(errorMessage: "Failed to get prayer"));
    }
  }

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
  Future<Either<Failure, Prayer>> getPreviousPrayer() {
    // TODO: implement getPreviousPrayer
    throw UnimplementedError();
  }
}
