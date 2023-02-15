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

  int currentPrayerIndex = 0;

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
      currentPrayerIndex = index;

      ///Will use the index of the prayer for today to limit the total list to
      ///all messages right unto this day, so that a user can page view scroll

      ///THe cut the total prayer list into half, right upto the day of today.
      ///Added +1 to the index cs the final list is actually from zero to the element at the index-1
      ///or 1 less than the element we actually want.

      allPrayers = allPrayers.sublist(0, index + 1);

      state = PrayerState.success;
    });
  }

  updateCurrentPrayerIndex(int value) {
    currentPrayerIndex = value;
    notifyListeners();
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
