import 'package:christabodenew/repositories/prayer_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/core.dart';
import '../models/prayer_model.dart';


class PrayerProvider extends ChangeNotifier {
  final PrayerRepository prayerRepository;
  AppState state = AppState.initial;
  String errorMessage = "";
  Prayer? todaysPrayer;

  List<Prayer> allPrayers = [];
  List<Prayer> likedPrayers = [];

  int currentPrayerIndex = 0;

  PrayerProvider({required this.prayerRepository});

  Future<void> getCurrentPrayer() async {
    if (state == AppState.submitting) return;

    state = AppState.submitting;
    // notifyListeners();

    Either<Failure, Prayer> response =
        await prayerRepository.getCurrentPrayer();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's prayer";
      state = AppState.error;
    }, (prayer) {
      todaysPrayer = prayer;
      state = AppState.success;
    });
    //   notifyListeners();
  }

  Future<void> getTodaysPrayerIndex() async {
    if (state == AppState.submitting) return;
    state = AppState.submitting;

    Either<Failure, int> response =
        await prayerRepository.getCurrentPrayerIndex();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's Prayer";
      state = AppState.error;
    }, (index) {
      currentPrayerIndex = index;

      ///Will use the index of the prayer for today to limit the total list to
      ///all messages right unto this day, so that a user can page view scroll

      ///THe cut the total prayer list into half, right upto the day of today.
      ///Added +1 to the index cs the final list is actually from zero to the element at the index-1
      ///or 1 less than the element we actually want.

      allPrayers = allPrayers.sublist(0, index + 1);

      state = AppState.success;
    });
  }

  updateCurrentPrayerIndex(int value) {
    currentPrayerIndex = value;
    notifyListeners();
  }

  Future<void> getPrayers() async {
    if (state == AppState.submitting) return;
    state = AppState.submitting;
    notifyListeners();

    Either<Failure, List<Prayer>> response =
        await prayerRepository.getPrayers();
    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's prayer";
      state = AppState.error;
    }, (prayer) {
      allPrayers = prayer;
      state = AppState.success;
    });
    notifyListeners();
  }

  Future<void> getLikedPrayers() async {
    if (state == AppState.submitting) return;
    state = AppState.submitting;
    notifyListeners();
    Either<Failure, List<Prayer>> response =
        await prayerRepository.getLikedPrayers();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting your favourite Prayers";

      state = AppState.error;
    }, (likedPrayer) {
      likedPrayers = likedPrayer;
      state = AppState.success;
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
      state = AppState.error;
    }, (nothing) {
      state = AppState.success;
    });
    notifyListeners();
  }

  Future<void> clearPrayer() async {
    Either<Failure, void> response = await prayerRepository.clearPrayers();
    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's prayer";
      state = AppState.error;
    }, (nothing) {
      state = AppState.success;
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
      state = AppState.success;
    } else {
      state = AppState.error;
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
