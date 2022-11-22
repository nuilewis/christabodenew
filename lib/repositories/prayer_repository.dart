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
  Future<Either<Failure, List<Prayer>>> getPrayers();
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

  List<Prayer> _prayerList = [];
  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);
  final DateTime _tomorrow = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day + 1, 0, 0, 0, 0, 0);
  int _currentPrayerIndex = 0;

  @override
  Future<Either<Failure, List<Prayer>>> getPrayers() async {
    Prayer prayer = Prayer.empty;

    /// try to get from offline
    /// if offline is empty, then check for network connectivity, if network is not there, throw a network error
    /// if network is there, then try to get from offline.

    ///Todo: try to get prayer offline, if its, empty then  retry online.
    _prayerList = await prayerHiveService.getData();
    if (_prayerList.isEmpty) {
      ///If the prayer list from local storage is empty, then try to get
      ///a new list from firestore;
      if (await connectionChecker.isConnected) {
        ///If there is a network connection, then make request to firebase to
        ///get the data.
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

              _prayerList.add(prayer);
            }
          }
          return Right(_prayerList);
        } on FirebaseException catch (e) {
          ///If a Firebase error has occurred, then return a [FirebaseFailure]
          return Left(FirebaseFailure(errorMessage: e.message, code: e.code));
        }
      } else {
        ///If there is no connection, then return a [NetworkFailure]
        return const Left(NetworkFailure());
      }
    } else {
      return const Left(FirebaseFailure(errorMessage: "Failed to get prayer"));
    }
  }

  @override
  Future<Either<Failure, Prayer>> getCurrentPrayer() async {
    if (_prayerList.isNotEmpty) {
      ///Gates the prayers whose dates and months are equal
      ///to the date and months of today.
      List<Prayer> todaysPrayer = _prayerList.where((element) =>
          element.date.month == _today.month &&
          element.date.day == _today.day) as List<Prayer>;
      return Right(todaysPrayer.first);
    } else {
      return const Left(FirebaseFailure(errorMessage: "No prayers found"));
    }
  }

  @override
  Future<Either<Failure, Prayer>> getNextPrayer() async {
    if (_prayerList.isNotEmpty) {
      //Get the index of the current prayer, then use it to get the next.
      ///Get the element where the date is after today at 12, AM, 0 sec, 0 millisec
      /// and is before tomorrow at 12 AM, O sec, O millisec
      _currentPrayerIndex = _prayerList.indexWhere((element) =>
          element.date.isAfter(_today) && element.date.isBefore(_tomorrow));

      Prayer nextPrayer = _prayerList[_currentPrayerIndex++];
      _currentPrayerIndex = _currentPrayerIndex++;
      return Right(nextPrayer);
    } else {
      return const Left(
          FirebaseFailure(errorMessage: "Unable to get the next prayer"));
    }
  }

  @override
  Future<Either<Failure, Prayer>> getPreviousPrayer() async {
    if (_prayerList.isNotEmpty) {
      //Get the index of the current prayer, then use it to get the previous

      Prayer previousPrayer = _prayerList[_currentPrayerIndex--];
      //Making sure to update the index of the current prayer by subtracting 1;
      _currentPrayerIndex = _currentPrayerIndex--;
      return Right(previousPrayer);
    } else {
      return const Left(
          FirebaseFailure(errorMessage: "Unable to get the previous Prayer"));
    }
  }
}
