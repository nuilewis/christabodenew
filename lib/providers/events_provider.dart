import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/errors/failure.dart';
import '../models/event_model.dart';
import '../repositories/events_repository.dart';

enum EventState { initial, submitting, success, error }

class EventsProvider extends ChangeNotifier {
  final EventsRepository eventsRepository;

  EventsProvider({required this.eventsRepository});

  EventState state = EventState.initial;
  String errorMessage = "";
  List<Event> allEvents = [];

  Future<void> getEvents() async {
    if (state == EventState.submitting) return;
    state = EventState.submitting;
    notifyListeners();

    Either<Failure, List<Event>> response = await eventsRepository.getEvents();

    response.fold((failure) {
      errorMessage =
          failure.errorMessage ?? "An error occurred while getting the events";
      state = EventState.error;
    }, (eventsList) {
      allEvents = eventsList;
      state = EventState.success;
    });

    notifyListeners();
  }
}
