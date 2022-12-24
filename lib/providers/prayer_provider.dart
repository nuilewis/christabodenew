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
  List<Prayer> likedPrayers = [];

  int todaysPrayerIndex = 0;

  PrayerProvider({required this.prayerRepository});

  Future<void> getCurrentPrayer() async {
    if (state == PrayerState.submitting) return;

    state = PrayerState.submitting;
    // notifyListeners();

    Either<Failure, Prayer> response =
        await prayerRepository.getCurrentPrayer();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's prayer";
      state = PrayerState.error;
    }, (prayer) {
      todaysPrayer = prayer;
      state = PrayerState.success;
    });
    //   notifyListeners();
  }

  Future<void> getTodaysPrayerIndex() async {
    if (state == PrayerState.submitting) return;
    state = PrayerState.submitting;

    Either<Failure, int> response =
        await prayerRepository.getCurrentPrayerIndex();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's Prayer";
      state = PrayerState.error;
    }, (index) {
      todaysPrayerIndex = index;
      state = PrayerState.success;
    });
  }

  Future<void> getPrayers() async {
    if (state == PrayerState.submitting) return;
    state = PrayerState.submitting;
    notifyListeners();

    Either<Failure, List<Prayer>> response =
        await prayerRepository.getPrayers();
    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's prayer";
      state = PrayerState.error;
    }, (prayer) {
      allPrayers = prayer;
      state = PrayerState.success;
    });
    notifyListeners();
  }

  Future<void> getLikedPrayers() async {
    if (state == PrayerState.submitting) return;
    state = PrayerState.submitting;
    notifyListeners();
    Either<Failure, List<Prayer>> response =
        await prayerRepository.getLikedPrayers();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting your favourite Prayers";

      state = PrayerState.error;
    }, (likedPrayer) {
      likedPrayers = likedPrayer;
      state = PrayerState.success;
    });

    notifyListeners();
  }

  ///Used for both liking and unliking devotionals, as well as any
  ///other updates to the devotional list that is necessary
  Future<void> updatePrayerList(List<Prayer> updatedList) async {
    Either<Failure, void> response =
        await prayerRepository.updatePrayerSavedList(updatedList);
    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's prayer";
      state = PrayerState.error;
    }, (nothing) {
      state = PrayerState.success;
    });
    notifyListeners();
  }

  Future<void> clearPrayer() async {
    Either<Failure, void> response = await prayerRepository.clearPrayers();
    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's prayer";
      state = PrayerState.error;
    }, (nothing) {
      state = PrayerState.success;
    });
    notifyListeners();
  }

  Future<void> toggleLikedPrayer(int index) async {
    if (allPrayers.isNotEmpty) {
      ///This sets [isLiked] to be the opposite of what is the current value
      Prayer updatedPrayer =
          allPrayers[index].copyWith(isLiked: !allPrayers[index].isLiked);
      List<Prayer> updatedList = allPrayers;
      updatedList.removeAt(index);
      updatedList.insert(index, updatedPrayer);

      await updatePrayerList(updatedList);
      await getLikedPrayers();
      state = PrayerState.success;
    } else {
      state = PrayerState.error;
    }
    notifyListeners();
  }

  Future<void> initStuff() async {
    await getPrayers();
    await getCurrentPrayer();
    await getLikedPrayers();
    await getTodaysPrayerIndex();
  }
}
