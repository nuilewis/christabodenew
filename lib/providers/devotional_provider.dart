import 'package:christabodenew/models/devotional_model.dart';
import 'package:christabodenew/repositories/devotional_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/errors/failure.dart';

enum DevotionalState { initial, submitting, success, error }

class DevotionalProvider extends ChangeNotifier {
  final DevotionalRepository devotionalRepository;
  DevotionalState state = DevotionalState.initial;
  String errorMessage = "";
  Devotional? todaysDevotional;
  //late final int todaysDevotionalIndex;
  int currentDevotionalIndex = 0;

  List<Devotional> allDevotionals = [];
  List<Devotional> likedDevotionals = [];

  DevotionalProvider(this.devotionalRepository);

  Future<void> getCurrentDevotional() async {
    if (state == DevotionalState.submitting) return;
    state = DevotionalState.submitting;
    //notifyListeners();
    Either<Failure, Devotional> response =
        await devotionalRepository.getCurrentDevotional();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's Devotional";
      state = DevotionalState.error;
    }, (devotional) {
      todaysDevotional = devotional;
      state = DevotionalState.success;
    });

    // notifyListeners();
  }

  Future<void> getTodaysDevotionalIndex() async {
    // if (state == DevotionalState.submitting) return;
    // state = DevotionalState.submitting;
    // //notifyListeners();

    Either<Failure, int> response =
        await devotionalRepository.getCurrentDevotionalIndex();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's Devotional";

      state = DevotionalState.error;
    }, (index) {
      ///Will use the index of the devotional for today to limit the total list to
      ///all messages right unto this day, so that a user can page view scroll
      currentDevotionalIndex = index;

      ///THe cut the total devotional list into half, right upto the day of today.
      ///Added +1 cs the final list is actually from zero to the element at the index-1
      ///or 1 less than the element we actually want.

      allDevotionals = allDevotionals.sublist(0, index + 1);

      state = DevotionalState.success;
    });

    // notifyListeners();
  }

  updateCurrentDevotionalIndex(int value) {
    currentDevotionalIndex = value;
    notifyListeners();
  }

  Future<void> getDevotionals() async {
    if (state == DevotionalState.submitting) return;
    state = DevotionalState.submitting;
    notifyListeners();
    Either<Failure, List<Devotional>> response =
        await devotionalRepository.getDevotionals();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's Devotional";

      state = DevotionalState.error;
    }, (devotional) {
      allDevotionals = devotional;

      state = DevotionalState.success;
    });

    notifyListeners();
  }

  Future<void> getLikedDevotionals() async {
    if (state == DevotionalState.submitting) return;
    state = DevotionalState.submitting;
    notifyListeners();
    Either<Failure, List<Devotional>> response =
        await devotionalRepository.getLikedDevotionals();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting your favourite Devotional messages";

      state = DevotionalState.error;
    }, (likedDevotional) {
      likedDevotionals = likedDevotional;
      state = DevotionalState.success;
    });

    notifyListeners();
  }

  ///Used for both liking and unliking devotionals, as well as any
  ///other updates to the devotional list that is necessary
  Future<void> updateDevotionalList(List<Devotional> updatedList) async {
    Either<Failure, void> response =
        await devotionalRepository.updateDevotionalSavedList(updatedList);

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while saving your favourite Devotional messages";
      state = DevotionalState.error;
    }, (nothing) {
      state = DevotionalState.success;
    });

    notifyListeners();
  }

  Future<void> clearDevotional() async {
    Either<Failure, void> response =
        await devotionalRepository.clearDevotionals();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while clearing Devotional messages";
      state = DevotionalState.error;
    }, (nothing) {
      state = DevotionalState.success;
    });

    notifyListeners();
  }

  Future<void> toggleLikedDevotional(int index) async {
    if (allDevotionals.isNotEmpty) {
      ///This sets [isLiked] to be the opposite of what is the current value
      Devotional updatedMessage = allDevotionals[index]
          .copyWith(isLiked: !allDevotionals[index].isLiked);
      List<Devotional> updatedList = allDevotionals;
      updatedList.removeAt(index);
      updatedList.insert(index, updatedMessage);

      await updateDevotionalList(updatedList);
      await getLikedDevotionals();
      state = DevotionalState.success;
    } else {
      state = DevotionalState.error;
    }
    notifyListeners();
  }

  Future<void> initStuff() async {
    await getDevotionals();
    await getCurrentDevotional();
    await getLikedDevotionals();
    await getTodaysDevotionalIndex();
  }
}
