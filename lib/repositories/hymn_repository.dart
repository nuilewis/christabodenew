import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/errors/failure.dart';
import 'package:christabodenew/models/models.dart';
import 'package:christabodenew/services/services.dart';

class HymnRepository {
  final HymnFireStoreService hymnFirestoreService;
  final HymnHiveService hymnHiveService;
  HymnRepository({
    required this.hymnHiveService,
    required this.hymnFirestoreService,

  });

  List<Hymn> _hymnList = [];
  List<Hymn> _likedHymnList = [];
  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);


  Future<Either<Failure, List<Hymn>>> getHymn() async {
  Hymn hymn = Hymn.empty;

    /// try to get from offline
    /// if offline is empty, then check for network connectivity, if network is not there, throw a network error
    /// if network is there, then try to get from offline.
    final Box hymnBox = await hymnHiveService.openBox();
    _hymnList = await hymnHiveService.getData(hymnBox);
    if (_hymnList.isEmpty) {
      ///If the prayer list from local storage is empty, then try to get
      ///a new list from firestore;

      ///If there is a network connection, then make request to firebase to
      ///get the data.
      try {
        QuerySnapshot querySnapshot =
        await hymnFirestoreService.getHymns();

        if (querySnapshot.docs.isNotEmpty) {
          for (DocumentSnapshot element in querySnapshot.docs) {
            Map<String, dynamic> documentData =
            element.data() as Map<String, dynamic>;

      hymn = Hymn.fromMap(data: documentData);



            _hymnList.add(hymn);
          }
        }

        ///Sorting the list in order before saving to the database

        _hymnList.sort((a, b) => a.number.compareTo(b.number));

        ///Now add the list of prayers to local storage

        await hymnHiveService.addHymn(hymnBox, _hymnList);
        return Right(_hymnList);
      } on FirebaseException catch (e) {
        ///If a Firebase error has occurred, then return a [FirebaseFailure]
        return Left(Failure(errorMessage: e.message, code: e.code));
      }
    } else {
      ///If there is no connection, then return a [NetworkFailure]
      return const Left(Failure.generic());
    }

  }




  ///-------Liked Hymn Methods--------///

  Future<Either<Failure, List<Hymn>>> getLikedHymns() async {
    try {
      _likedHymnList =
          _hymnList.where((element) => element.isLiked == true).toList();

      return Right(_likedHymnList);
    } catch (e) {
      return const Left(
          Failure(errorMessage: "Unable to get your liked Hymns"));
    }
  }

  Future<Either<Failure, void>> updateHymnSavedList(
      List<Hymn> updatedList) async {
    final Box box = await hymnHiveService.openBox();
    try {
      await hymnHiveService.addHymn(box, updatedList);
      return const Right(null);
    } catch (e) {
      return const Left(
          Failure(errorMessage: "Unable to add to your favourites"));
    }
  }

  Future<Either<Failure, void>> clearHymn() async {
    final Box box = await hymnHiveService.openBox();
    try {
      await hymnHiveService.clearHymn(box);
      return const Right(null);
    } catch (e) {
      return const Left(
          Failure(errorMessage: "Unable to clear your favourites"));
    }
  }
}
