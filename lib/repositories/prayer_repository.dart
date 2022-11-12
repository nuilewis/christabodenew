import 'package:christabodenew/services/prayer/prayer_hive_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

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
  PrayerRepositoryImplementation({
    required this.prayerHiveService,
    required this.prayerFirestoreService,
  });
  @override
  Future<Either<Failure, Prayer>> getPrayers() async {
    List<Prayer> prayerList = [];
    Prayer prayer = Prayer.empty;

    ///Todo: consider removing this network checker, because firebase already has an offline functionality
    ///and the network checker will just prevent firebase from working properly
    ///cs it will intercept that theres no network and throw an error, event though firebase could still get the
    ///document offline.

    ///Also do i save each prayer as a separate entry, or as a giant map of all entries in one document??
    ///May be useful to do so in order to show a list of the complete prayers, and also reduce reads
    ///but it may be too large for one document, and same thing with the messages, would.
    ///Saving each message in its own document would not be terrible idea, but again, we're trying to be efficient
    ///a list of maps for the messages and prayers makes sense right??
    try {
      DocumentSnapshot documentSnapshot =
          await prayerFirestoreService.getPrayer();

      if (documentSnapshot.exists) {
        Map<String, dynamic> documentData =
            documentSnapshot.data() as Map<String, dynamic>;
        String excerpt = documentData["content"].toString();

        prayer = Prayer(
          title: documentData["title"],
          scripture: documentData["scripture"],
          scriptureReference: documentData["scriptureRef"],
          content: documentData["content"],
          date: documentData["startDate"],
          excerpt: excerpt,
        );
      }
      return Right(prayer);
    } on FirebaseException catch (e) {
      return Left(Failure(errorMessage: e.message, code: e.code));
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
