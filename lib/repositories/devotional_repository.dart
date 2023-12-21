import 'package:christabodenew/models/devotional_model.dart';
import 'package:christabodenew/services/devotional/devotional_firestore_service.dart';
import 'package:christabodenew/services/devotional/devotional_hive_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/errors/failure.dart';

class DevotionalRepository {
  final DevotionalFirestoreService devotionalFirestoreService;
  final DevotionalHiveService devotionalHiveService;

  DevotionalRepository({
    required this.devotionalFirestoreService,
    required this.devotionalHiveService,
  });

  List<Devotional> _devotionalList = [];
  List<Devotional> _likedDevotionalsList = [];
  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);

  Future<Either<Failure, List<Devotional>>> getDevotionals(
      {String? year}) async {
    final Box devotionalBox = await devotionalHiveService.openBox();
    _devotionalList = await devotionalHiveService.getData(devotionalBox);
    if (_devotionalList.isNotEmpty) {
      print("Not getting devotionals from remote because data already exist");
      return Right(_devotionalList);
    } else {
      try {
        QuerySnapshot querySnapshot =
            await devotionalFirestoreService.getDevotionals(year: year);

        if (querySnapshot.docs.isNotEmpty) {
          for (DocumentSnapshot monthlyDocs in querySnapshot.docs) {
            List<dynamic> monthlyList =
                monthlyDocs["devotional"] as List<dynamic>;

            for (Map<String, dynamic> element in monthlyList) {
              _devotionalList.add(Devotional.fromMap(data: element));
            }
          }
        }

        ///Sorting the list in order according to their star dates before adding to the database
        _devotionalList.sort((a, b) => a.startDate.compareTo(b.startDate));

        ///Now add the list of devotionals to the hive database
        await devotionalHiveService.addDevotional(
            devotionalBox, _devotionalList);
        return Right(_devotionalList);
      } on FirebaseException catch (e) {
        return Left(Failure(errorMessage: e.message, code: e.code));
      } catch (e) {
        return const Left(Failure(errorMessage: "An error has occurred"));
      }
    }
  }

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
        return const Left(Failure(errorMessage: "No Devotional message found"));
      } else {
        return Right(todaysDevotional.first);
      }
    } else {
      return const Left(Failure(errorMessage: "No Devotional found"));
    }
  }

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
        ///Index being -1 means it did not get the devotional, or the devotional was not found

        return const Left(Failure(errorMessage: "No Devotional message found"));
      } else {
        return Right(todaysDevotionalIndex);
      }
    } else {
      return const Left(Failure(errorMessage: "No Devotional found"));
    }
  }

  ///-------Liked Devotionals Methods--------///

  Future<Either<Failure, List<Devotional>>> getLikedDevotionals() async {
    try {
      _likedDevotionalsList =
          _devotionalList.where((element) => element.isLiked == true).toList();
      return Right(_likedDevotionalsList);
    } catch (e) {
      return const Left(Failure(
          errorMessage: "Unable to get your favourite devotional messages"));
    }
  }

  Future<Either<Failure, void>> updateDevotionalSavedList(
      List<Devotional> updatedList) async {
    final Box box = await devotionalHiveService.openBox();
    try {
      await devotionalHiveService.addDevotional(box, updatedList);
      return const Right(null);
    } catch (e) {
      return const Left(
          Failure(errorMessage: "Unable to add to your favourites"));
    }
  }

  Future<Either<Failure, void>> clearDevotionals() async {
    final Box box = await devotionalHiveService.openBox();
    try {
      await devotionalHiveService.clearDevotional(box);
      return const Right(null);
    } catch (e) {
      return const Left(
          Failure(errorMessage: "Unable to clear your favourites"));
    }
  }
}
