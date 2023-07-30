import 'package:christabodenew/services/prayer/prayer_hive_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/connection_checker/connection_checker.dart';
import '../core/errors/failure.dart';
import '../models/prayer_model.dart';
import '../services/prayer/prayer_firestore_service.dart';

class PrayerRepository {
  final PrayerFireStoreService prayerFirestoreService;
  final PrayerHiveService prayerHiveService;
  final ConnectionChecker connectionChecker;
  PrayerRepository({
    required this.prayerHiveService,
    required this.prayerFirestoreService,
    required this.connectionChecker,
  });

  List<Prayer> _prayerList = [];
  List<Prayer> _likedPrayerList = [];
  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);

  Future<Either<Failure, List<Prayer>>> getPrayers() async {
    Prayer prayer = Prayer.empty;

    /// try to get from offline
    /// if offline is empty, then check for network connectivity, if network is not there, throw a network error
    /// if network is there, then try to get from offline.
    final Box prayerBox = await prayerHiveService.openBox();
    _prayerList = await prayerHiveService.getData(prayerBox);
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
            for (DocumentSnapshot element in querySnapshot.docs) {
              Map<String, dynamic> documentData =
                  element.data() as Map<String, dynamic>;

              prayer = Prayer.fromMap(data: documentData);

              _prayerList.add(prayer);
            }
          }

          ///Sorting the list in order before saving to the database

          _prayerList.sort((a, b) => a.date.compareTo(b.date));

          ///Now add the list of prayers to local storage

          await prayerHiveService.addPrayers(prayerBox, _prayerList);
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
      return Right(_prayerList);
    }
  }

  Future<Either<Failure, Prayer>> getCurrentPrayer() async {
    if (_prayerList.isNotEmpty) {
      ///Gates the prayers whose dates and months are equal
      ///to the date and months of today.
      List<Prayer> todaysPrayer = _prayerList
          .where((element) =>
                  element.date.month == _today.month &&
                  element.date.day == _today.day

              ///We compare only the months and days rather than comparing
              ///the whole date, to make the year irrelevant, that way the prayers
              ///will be gotten regardless of the year.
              )
          .toList();
      if (todaysPrayer.isEmpty) {
        return const Left(FirebaseFailure(errorMessage: "No Prayers Found"));
      } else {
        return Right(todaysPrayer.first);
      }
    } else {
      return const Left(FirebaseFailure(errorMessage: "No prayers found"));
    }
  }

  Future<Either<Failure, int>> getCurrentPrayerIndex() async {
    if (_prayerList.isNotEmpty) {
      int todaysDevotionalIndex = _prayerList.indexWhere(
        (element) =>
            _today.month == element.date.month &&
            _today.day == element.date.day,

        ///There is only one case here, since there are atlas 1 prayer each day
        ///therefore no prayer repeats, or spans for multiple days, meaning
        ///we can check the prayer whose date matches the day of today
        ///
        /// Now we compare only the days and months so we can exclude the years
        /// since the prayers will be the same each year. Comparing the years
        /// will mean that the prayers will only be valid for 1 year.
      );

      if (todaysDevotionalIndex == -1) {
        ///Index being -1 means it did not get the prayer, or the prayer was not found

        return const Left(FirebaseFailure(errorMessage: "No Prayers"));
      } else {
        return Right(todaysDevotionalIndex);
      }
    } else {
      return const Left(FirebaseFailure(errorMessage: "No Prayers found"));
    }
  }

  ///-------Liked Prayer Methods--------///

  Future<Either<Failure, List<Prayer>>> getLikedPrayers() async {
    try {
      _likedPrayerList =
          _prayerList.where((element) => element.isLiked == true).toList();

      return Right(_likedPrayerList);
    } catch (e) {
      return const Left(
          FirebaseFailure(errorMessage: "Unable to get your liked prayers"));
    }
  }

  Future<Either<Failure, void>> updatePrayerSavedList(
      List<Prayer> updatedList) async {
    final Box box = await prayerHiveService.openBox();
    try {
      await prayerHiveService.addPrayers(box, updatedList);
      return const Right(null);
    } catch (e) {
      return const Left(
          FirebaseFailure(errorMessage: "Unable to add to your favourites"));
    }
  }

  Future<Either<Failure, void>> clearPrayers() async {
    final Box box = await prayerHiveService.openBox();
    try {
      await prayerHiveService.clearPrayers(box);
      return const Right(null);
    } catch (e) {
      return const Left(
          FirebaseFailure(errorMessage: "Unable to clear your favourites"));
    }
  }
}
