import 'package:christabodenew/core/errors/failure.dart';
import 'package:christabodenew/repositories/prayer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/prayer_model.dart';

enum PrayerStatus { initial, submitting, success, error }

class PrayerProvider extends ChangeNotifier {
  final PrayerRepository prayerRepository;
  PrayerStatus status = PrayerStatus.initial;
  String errorMessage = "";
  Prayer? todaysPrayer;

  PrayerProvider({required this.prayerRepository});

  Future<void> getCurrentPrayer() async {
    if (status == PrayerStatus.submitting) return;
    Either<Failure, Prayer> response =
        await prayerRepository.getCurrentPrayer();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occured while getting today's prayer";
      status == PrayerStatus.error;

      notifyListeners();
    }, (prayer) {
      todaysPrayer = prayer;
      status == PrayerStatus.success;

      notifyListeners();
    });
  }

  Future<void> getNextPrayer() async {
    if (status == PrayerStatus.submitting) return;

    Either<Failure, Prayer> response = await prayerRepository.getNextPrayer();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occured while getting today's prayer";
      status == PrayerStatus.error;

      notifyListeners();
    }, (prayer) {
      todaysPrayer = prayer;
      status == PrayerStatus.success;

      notifyListeners();
    });
  }

  Future<void> getPreviousPrayer() async {
    if (status == PrayerStatus.submitting) return;

    Either<Failure, Prayer> response =
        await prayerRepository.getPreviousPrayer();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occured while getting today's prayer";
      status == PrayerStatus.error;

      notifyListeners();
    }, (prayer) {
      todaysPrayer = prayer;
      status == PrayerStatus.success;

      notifyListeners();
    });
  }

  Future<void> getPrayer() async {
    if (status == PrayerStatus.submitting) return;

    Either<Failure, Prayer> response = await prayerRepository.getPrayer();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occured while getting today's prayer";
      status == PrayerStatus.error;

      notifyListeners();
    }, (prayer) {
      todaysPrayer = prayer;
      status == PrayerStatus.success;
      notifyListeners();
    });
  }
}
