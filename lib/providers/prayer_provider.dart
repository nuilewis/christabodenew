import 'package:christabodenew/core/errors/failure.dart';
import 'package:christabodenew/repositories/prayer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../models/prayer_model.dart';

enum PrayerState { initial, submitting, success, error }

class PrayerProvider extends ChangeNotifier {
  final PrayerRepository prayerRepository;
  PrayerState state = PrayerState.initial;
  String errorMessage = "";
  Prayer? todaysPrayer;
  List<Prayer> allPrayers = [];

  PrayerProvider({required this.prayerRepository});

  Future<void> getCurrentPrayer() async {
    if (state == PrayerState.submitting) return;

    state = PrayerState.submitting;
    notifyListeners();

    Either<Failure, Prayer> response =
        await prayerRepository.getCurrentPrayer();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's prayer";
      print(errorMessage);
      state = PrayerState.error;
    }, (prayer) {
      todaysPrayer = prayer;
      state = PrayerState.success;
    });
    notifyListeners();
  }

  Future<void> getNextPrayer() async {
    if (state == PrayerState.submitting) return;
    state = PrayerState.submitting;
    notifyListeners();
    Either<Failure, Prayer> response = await prayerRepository.getNextPrayer();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's prayer";
      print(errorMessage);
      state = PrayerState.error;

      notifyListeners();
    }, (prayer) {
      todaysPrayer = prayer;
      state = PrayerState.success;

      notifyListeners();
    });
  }

  Future<void> getPreviousPrayer() async {
    if (state == PrayerState.submitting) return;
    state = PrayerState.submitting;
    notifyListeners();
    Either<Failure, Prayer> response =
        await prayerRepository.getPreviousPrayer();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's prayer";
      print(errorMessage);
      state = PrayerState.error;
    }, (prayer) {
      todaysPrayer = prayer;
      state = PrayerState.success;
    });

    notifyListeners();
  }

  Future<void> getPrayer() async {
    print("get prayer is running");
    if (state == PrayerState.submitting) return;
    state = PrayerState.submitting;
    notifyListeners();

    Either<Failure, List<Prayer>> response =
        await prayerRepository.getPrayers();
    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's prayer";
      print(errorMessage);
      state = PrayerState.error;
    }, (prayer) {
      allPrayers = prayer;
      state = PrayerState.success;
    });
    notifyListeners();
  }
}
