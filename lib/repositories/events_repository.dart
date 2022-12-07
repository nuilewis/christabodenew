import 'package:christabodenew/core/connection_checker/connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../core/errors/failure.dart';
import '../models/event_model.dart';
import '../services/events/event_hive_service.dart';
import '../services/events/events_firestore_service.dart';

abstract class EventsRepository {
  Future<Either<Failure, List<Event>>> getEvents();
}

class EventsRepositoryImplementation implements EventsRepository {
  final EventsFirestoreService eventsFirestoreService;
  final EventsHiveService eventsHiveService;
  final ConnectionChecker connectionChecker;

  EventsRepositoryImplementation(
      {required this.eventsFirestoreService,
      required this.eventsHiveService,
      required this.connectionChecker});

  List<Event> _eventsList = [];

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    final Box eventBox = await eventsHiveService.openBox();
    _eventsList = await eventsHiveService.getData(eventBox);

    if (_eventsList.isEmpty) {
      if (await connectionChecker.isConnected) {
        try {
          QuerySnapshot querySnapshot =
              await eventsFirestoreService.getEvents();

          if (querySnapshot.docs.isNotEmpty) {
            for (var element in querySnapshot.docs) {
              Map<String, dynamic> documentData =
                  element.data() as Map<String, dynamic>;
              Timestamp startDate = documentData["start"];
              Timestamp endDate = documentData["end"];
              Event event = Event(
                name: documentData["name"],
                description: documentData["description"],
                startDate: startDate.toDate(),
                endDate: endDate.toDate(),
              );

              _eventsList.add(event);
            }
          }
          return Right(_eventsList);
        } on FirebaseException catch (e) {
          return Left(FirebaseFailure(errorMessage: e.message, code: e.code));
        }
      } else {
        return const Left(NetworkFailure());
      }
    } else {
      return Right(_eventsList);
    }
  }
}
