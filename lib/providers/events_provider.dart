import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

import '../core/core.dart';
import '../models/event_model.dart';
import '../repositories/events_repository.dart';

class EventsProvider extends ChangeNotifier {
  final EventsRepository eventsRepository;

  EventsProvider({required this.eventsRepository});

  AppState state = AppState.initial;
  String? errorMessage;
  List<Event> allEvents = [];
  List<Event> monthlyEvents = [];
  List<Event> pastEvents = [];
  List<Event> upcomingEvents = [];

  Future<void> getEvents({String? year}) async {
    if (state == AppState.submitting) return;
    state = AppState.submitting;
    notifyListeners();

    Either<Failure, List<Event>> response =
        await eventsRepository.getEvents(year: year);

    response.fold((failure) {
      errorMessage =
          failure.errorMessage ?? "An error occurred while getting the events";
      state = AppState.error;
    }, (eventsList) {
      allEvents = eventsList;
      state = AppState.success;
    });

    notifyListeners();
  }

  Future<void> getMonthlyEvents() async {
    if (state == AppState.submitting) return;
    state = AppState.submitting;
    notifyListeners();

    Either<Failure, List<Event>> response =
        await eventsRepository.getMonthlyEvents();

    response.fold((failure) {
      errorMessage =
          failure.errorMessage ?? "An error occurred while getting the events";
      state = AppState.error;
    }, (eventsList) {
      monthlyEvents = eventsList;
      state = AppState.success;
    });

    notifyListeners();
  }

  Future<void> getUpcomingEvents() async {
    if (state == AppState.submitting) return;
    state = AppState.submitting;
    //  notifyListeners();

    Either<Failure, List<Event>> response =
        await eventsRepository.getUpcomingEvents();

    response.fold((failure) {
      errorMessage = failure.errorMessage ?? "There are no upcoming events";
      state = AppState.error;
      upcomingEvents = [];
    }, (upcomingEventsList) {
      upcomingEvents = upcomingEventsList;
      state = AppState.success;
    });

    //notifyListeners();
  }

  Future<void> getPastEvents() async {
    if (state == AppState.submitting) return;
    state = AppState.submitting;
    notifyListeners();

    Either<Failure, List<Event>> response =
        await eventsRepository.getPastEvents();
    response.fold((failure) {
      errorMessage = failure.errorMessage ?? "There are no past events";
      state = AppState.error;
      pastEvents = [];
    }, (pastEventsList) {
      pastEvents = pastEventsList;
      state = AppState.success;
    });

    notifyListeners();
  }

  Future<void> initialise({String? eventsYear}) async {
    await getEvents(year: eventsYear).whenComplete(() async {
      await getMonthlyEvents();
      await getUpcomingEvents();
      await getPastEvents();
    });
  }

  void shareEvent(BuildContext context, Event event) async {
    String constructedText = """    
Join us for a Spirit filled encounter during our *${event.name.trim()}* on *${dateTimeFormatter(context, event.startDate)}.*

*Christ Abode Ministries.*

www.christabodeministries.org
Shared from the Christ Abode Ministries App
Available on the Google Play Store
https://play.google.com/store/apps/details?id=com.christabodeministries.cam""";

    await Share.share(constructedText);
  }
}
