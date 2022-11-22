import 'package:christabodenew/core/connection_checker/connection_checker.dart';
import 'package:christabodenew/models/devotional_model.dart';
import 'package:christabodenew/services/devotional/devotional_firestore_service.dart';
import 'package:christabodenew/services/devotional/devotional_hive_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../core/errors/failure.dart';

abstract class DevotionalRepository {
  Future<Either<Failure, Devotional>> getCurrentDevotional();
  Future<Either<Failure, Devotional>> getNextDevotional();
  Future<Either<Failure, Devotional>> getPreviousDevotional();
  Future<Either<Failure, List<Devotional>>> getDevotionals();
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
  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);
  int _currentDevotionalIndex = 0;

  @override
  Future<Either<Failure, List<Devotional>>> getDevotionals() async {
    Devotional devotional = Devotional.empty;

    /// try to get from offline
    /// if offline is empty, then check for network connectivity, if network is not there, throw a network error
    /// if network is there, then try to get from offline.

    _devotionalList = await devotionalHiveService.getData();
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
            for (var element in querySnapshot.docs) {
              Map<String, dynamic> documentData =
                  element.data() as Map<String, dynamic>;
              String excerpt =
                  documentData["content"].toString().substring(0, 20);
              devotional = Devotional(
                title: documentData["title"],
                scripture: documentData["scripture"],
                scriptureReference: documentData["scriptureRef"],
                content: documentData["content"],
                startDate: documentData["start"],
                endDate: documentData["end"],
                excerpt: excerpt,
                confessionOfFaith: documentData["confession"],
                author: documentData["author"],
              );

              _devotionalList.add(devotional);
            }
          }
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
      return const Left(
          FirebaseFailure(errorMessage: "Failed to get Devotional"));
    }
  }

  @override
  Future<Either<Failure, Devotional>> getCurrentDevotional() async {
    if (_devotionalList.isNotEmpty) {
      List<Devotional> todaysDevotional = _devotionalList.where((element) =>
          _today.isAfter(element.startDate) &&
          _today.isBefore(element.endDate)) as List<Devotional>;
      return Right(todaysDevotional.first);
    } else {
      return const Left(FirebaseFailure(errorMessage: "No Devotional found"));
    }
  }

  @override
  Future<Either<Failure, Devotional>> getNextDevotional() async {
    if (_devotionalList.isNotEmpty) {
      //Get the index of the current prayer, then use it to get the next.
      _currentDevotionalIndex = _devotionalList.indexWhere((element) =>
          _today.isAfter(element.startDate) &&
          _today.isBefore(element.endDate));

      Devotional nextDevotional = _devotionalList[_currentDevotionalIndex++];
      _currentDevotionalIndex = _currentDevotionalIndex++;
      return Right(nextDevotional);
    } else {
      return const Left(
          FirebaseFailure(errorMessage: "Unable to get the next devotional"));
    }
  }

  @override
  Future<Either<Failure, Devotional>> getPreviousDevotional() async {
    if (_devotionalList.isNotEmpty) {
      //Get the index of the current prayer, then use it to get the next.

      Devotional previousDevotional =
          _devotionalList[_currentDevotionalIndex--];
      _currentDevotionalIndex = _currentDevotionalIndex--;
      return Right(previousDevotional);
    } else {
      return const Left(FirebaseFailure(
          errorMessage: "Unable to get the previous devotional"));
    }
  }
}
