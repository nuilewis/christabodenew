import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../core/errors/failure.dart';
import '../models/event_model.dart';
import '../services/events/event_hive_service.dart';
import '../services/events/events_firestore_service.dart';

class EventsRepository {
  final EventsFirestoreService eventsFirestoreService;
  final EventsHiveService eventsHiveService;

  EventsRepository(
      {required this.eventsFirestoreService,
      required this.eventsHiveService,
});

  List<Event> _eventsList = [];
  List<Event> _monthlyEvents = [];
  List<Event> _upcomingEvents = [];
  List<Event> _pastEvents = [];

  final DateTime _today = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 0, 0, 0, 0, 0);

  Future<Either<Failure, List<Event>>> getEvents({String? year}) async {
    final Box eventBox = await eventsHiveService.openBox();
    _eventsList = await eventsHiveService.getData(eventBox);

    if (_eventsList.isNotEmpty) {
      print("Not getting devotionals from remote because data already exist");
      return Right(_eventsList);
    } else {

        try {
          DocumentSnapshot docSnapshot =
              await eventsFirestoreService.getEvents(year: year);

          if(docSnapshot.exists){
            Map<String, dynamic> documentData = docSnapshot.data() as Map<String, dynamic>;
            for(Map<String, dynamic> element in documentData["events"]){
              _eventsList.add(Event.fromMap(data: element));
            }
          }

          ///Sort the events to make sure they are in order
          _eventsList.sort((a, b) => a.startDate.compareTo(b.startDate));

          ///Add the events to the local database.
          await eventsHiveService.addEvents(eventBox, _eventsList);
          return Right(_eventsList);
        } on FirebaseException catch (e) {
          return Left(Failure(errorMessage: e.message, code: e.code));
        } catch (e){
          return const Left(Failure(errorMessage: "An error has occurred"));
        }
      }

  }

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
     Failure(errorMessage: "There are no past events"));
    }
  }

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
          Failure(errorMessage: "There are no upcoming events"));
    }
  }

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
      return const Left(Failure(
          errorMessage: "There are no events scheduled this month"));
    }
  }
}
