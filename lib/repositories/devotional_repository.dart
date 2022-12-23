import 'package:christabodenew/core/connection_checker/connection_checker.dart';
import 'package:christabodenew/models/devotional_model.dart';
import 'package:christabodenew/services/devotional/devotional_firestore_service.dart';
import 'package:christabodenew/services/devotional/devotional_hive_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/errors/failure.dart';

abstract class DevotionalRepository {
  Future<Either<Failure, Devotional>> getCurrentDevotional();
  Future<Either<Failure, int>> getCurrentDevotionalIndex();
  Future<Either<Failure, List<Devotional>>> getDevotionals();

  ///Liking Devotional Methods
  Future<Either<Failure, List<Devotional>>> getLikedDevotionals();
  Future<Either<Failure, void>> updateDevotionalSavedList(
      List<Devotional> updatedList);
  Future<Either<Failure, void>> clearDevotionals();
}

class DevotionalRepositoryImplementation implements DevotionalRepository {
  final DevotionalFirestoreService devotionalFirestoreService;
  final DevotionalHiveService devotionalHiveService;
  final ConnectionChecker connectionChecker;

  DevotionalRepositoryImplementation(
      {required this.devotionalFirestoreService,
      required this.devotionalHiveService,
      required this.connectionChecker});

  List<Devotional> _devotionalList = [];
  List<Devotional> _likedDevotionalsList = [];
  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);

  @override
  Future<Either<Failure, List<Devotional>>> getDevotionals() async {
    Devotional devotional = Devotional.empty;

    /// try to get from offline
    /// if offline is empty, then check for network connectivity, if network is not there, throw a network error
    /// if network is there, then try to get from offline.
    final Box devotionalBox = await devotionalHiveService.openBox();

    _devotionalList = await devotionalHiveService.getData(devotionalBox);

    if (_devotionalList.isEmpty) {
      ///If the devotional list from local storage is empty, then try to get
      ///a new list from firestore;
      if (await connectionChecker.isConnected) {
        ///If there is a network connection, then make request to firebase to
        ///get the data.
        try {
          QuerySnapshot querySnapshot =
              await devotionalFirestoreService.getDevotionals();

          if (querySnapshot.docs.isNotEmpty) {
            for (DocumentSnapshot element in querySnapshot.docs) {
              Map<String, dynamic> documentData =
                  element.data() as Map<String, dynamic>;
              devotional = Devotional.fromMap(data: documentData);

              _devotionalList.add(devotional);
            }
          }

          ///Sorting the list in order according to their star dates before adding to the database
          _devotionalList.sort((a, b) => a.startDate.compareTo(b.startDate));

          ///Now add the list of devotionals to the hive database
          await devotionalHiveService.addDevotional(
              devotionalBox, _devotionalList);

          return Right(_devotionalList);
        } on FirebaseException catch (e) {
          ///If a Firebase error has occurred, then return a [FirebaseFailure]
          return Left(FirebaseFailure(errorMessage: e.message, code: e.code));
        }
      } else {
        ///If there is no connection, then return a [NetworkFailure]
        return const Left(NetworkFailure());
      }
    } else {
      return Right(_devotionalList);
    }
  }

  @override
  Future<Either<Failure, Devotional>> getCurrentDevotional() async {
    if (_devotionalList.isNotEmpty) {
      List<Devotional> todaysDevotional = _devotionalList
          .where((element) =>
                  _today == element.startDate ||
                  _today == element.endDate ||
                  _today.isAfter(element.startDate) &&
                      _today.isBefore(element.endDate)

              ///There are 3 cases here for which a devotional message is returned.
              ///
              ///1. Either today is equal to the start date of the devotional message
              ///2. Or Today is equal to the end date of the devotional message
              ///
              ///These 2 cases cover all messages that are 2 days long.
              ///
              /// 3. And finally Today falls between the start date of the devotional message and the
              /// the end date of the devotional message.
              /// This case covers messages where it runs for 3 or more days.

              )
          .toList();

      if (todaysDevotional.isEmpty) {
        return const Left(
            FirebaseFailure(errorMessage: "No Devotional message found"));
      } else {
        return Right(todaysDevotional.first);
      }
    } else {
      return const Left(FirebaseFailure(errorMessage: "No Devotional found"));
    }
  }

  @override
  Future<Either<Failure, int>> getCurrentDevotionalIndex() async {
    if (_devotionalList.isNotEmpty) {
      int todaysDevotionalIndex = _devotionalList.indexWhere((element) =>
              _today == element.startDate ||
              _today == element.endDate ||
              _today.isAfter(element.startDate) &&
                  _today.isBefore(element.endDate)

          ///There are 3 cases here for which a devotional message is returned.
          ///
          ///1. Either today is equal to the start date of the devotional message
          ///2. Or Today is equal to the end date of the devotional message
          ///
          ///These 2 cases cover all messages that are 2 days long.
          ///
          /// 3. And finally Today falls between the start date of the devotional message and the
          /// the end date of the devotional message.
          /// This case covers messages where it runs for 3 or more days.

          );

      if (todaysDevotionalIndex == -1) {
        ///Inde being -1 means it did not get the devotional, ot the devotiona was nto found

        return const Left(
            FirebaseFailure(errorMessage: "No Devotional message found"));
      } else {
        return Right(todaysDevotionalIndex);
      }
    } else {
      return const Left(FirebaseFailure(errorMessage: "No Devotional found"));
    }
  }

  ///-------Liked Devotionals Methods--------///
  @override
  Future<Either<Failure, List<Devotional>>> getLikedDevotionals() async {
    try {
      _likedDevotionalsList =
          _devotionalList.where((element) => element.isLiked == true).toList();
      return Right(_likedDevotionalsList);
    } catch (e) {
      return const Left(FirebaseFailure(
          errorMessage: "Unable to get your favourite devotional messages"));
    }
  }

  @override
  Future<Either<Failure, void>> updateDevotionalSavedList(
      List<Devotional> updatedList) async {
    final Box box = await devotionalHiveService.openBox();
    try {
      await devotionalHiveService.addDevotional(box, updatedList);
      return Right(Future.value());
    } catch (e) {
      return const Left(
          FirebaseFailure(errorMessage: "Unable to add to your favourites"));
    }
  }

  @override
  Future<Either<Failure, void>> clearDevotionals() async {
    final Box box = await devotionalHiveService.openBox();
    try {
      await devotionalHiveService.clearDevotional(box);
      return Right(Future.value());
    } catch (e) {
      return const Left(
          FirebaseFailure(errorMessage: "Unable to clear your favourites"));
    }
  }
}
