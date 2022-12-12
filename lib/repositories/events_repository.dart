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
  Future<Either<Failure, List<Event>>> getUpcomingEvents();
  Future<Either<Failure, List<Event>>> getPastEvents();
  Future<Either<Failure, List<Event>>> getMonthlyEvents();
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
  List<Event> _monthlyEvents = [];
  List<Event> _upcomingEvents = [];
  List<Event> _pastEvents = [];

  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);

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
            for (DocumentSnapshot element in querySnapshot.docs) {
              Map<String, dynamic> documentData =
                  element.data() as Map<String, dynamic>;
              Event event = Event.fromMap(data: documentData);
              _eventsList.add(event);
            }
          }

          ///Sort the events to make sure they are in order
          _eventsList.sort((a, b) => a.startDate.compareTo(b.startDate));

          ///Add the events to the local database.
          await eventsHiveService.addEvents(eventBox, _eventsList);
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

  @override
  Future<Either<Failure, List<Event>>> getPastEvents() async {
    ///We now find our past and present events for the month rather than for all time.
    if (_eventsList.isNotEmpty) {
      _pastEvents = _monthlyEvents
          .where((element) => element.startDate.isBefore(_today))
          .toList();
      _pastEvents.sort((a, b) => a.startDate.compareTo(b.startDate));
      return Right(_pastEvents);
    } else {
      return const Left(
          FirebaseFailure(errorMessage: "There are no past events"));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getUpcomingEvents() async {
    if (_eventsList.isNotEmpty) {
      ///We now find our past and present events for the month rather than for all time.
      _upcomingEvents = _monthlyEvents
          .where(
            (element) =>
                element.startDate == _today ||
                element.startDate.isAfter(_today),
          )
          .toList();
      _upcomingEvents.sort((a, b) => a.startDate.compareTo(b.startDate));
      return Right(_upcomingEvents);
    } else {
      return const Left(
          FirebaseFailure(errorMessage: "There are no past events"));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getMonthlyEvents() async {
    if (_eventsList.isNotEmpty) {
      _monthlyEvents = _eventsList
          .where((element) =>
              element.startDate.month == _today.month &&
              element.startDate.year == _today.year)
          .toList();
      _monthlyEvents.sort((a, b) => a.startDate.compareTo(b.startDate));
      return Right(_monthlyEvents);
    } else {
      return const Left(FirebaseFailure(
          errorMessage: "There are no events scheduled this month"));
    }
  }
}
