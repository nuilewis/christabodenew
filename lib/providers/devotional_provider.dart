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
  Devotional? currentDevotional;
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
      currentDevotional = devotional;
      state = DevotionalState.success;
    });

    // notifyListeners();
  }

  Future<void> getNextDevotional() async {
    if (state == DevotionalState.submitting) return;
    state = DevotionalState.submitting;
    notifyListeners();
    Either<Failure, Devotional> response =
        await devotionalRepository.getNextDevotional();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's Devotional";

      state = DevotionalState.error;
    }, (nextDevotional) {
      currentDevotional = nextDevotional;
      state = DevotionalState.success;
    });
    notifyListeners();
  }

  Future<void> getPreviousDevotional() async {
    if (state == DevotionalState.submitting) return;
    state = DevotionalState.submitting;
    notifyListeners();

    Either<Failure, Devotional> response =
        await devotionalRepository.getPreviousDevotional();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occurred while getting today's Devotional";

      state = DevotionalState.error;
    }, (previousDevotional) {
      currentDevotional = previousDevotional;
      state = DevotionalState.success;
    });
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
}
