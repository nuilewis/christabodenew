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
  List<Devotional> allDevotionals = [];

  DevotionalProvider(this.devotionalRepository);

  Future<void> getCurrentDevotional() async {
    if (state == DevotionalState.submitting) return;
    state = DevotionalState.submitting;
    notifyListeners();
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

    notifyListeners();
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
    }, (devotional) {
      todaysDevotional = devotional;
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
    }, (devotional) {
      todaysDevotional = devotional;
      state = DevotionalState.success;
    });
    notifyListeners();
  }

  Future<void> getDevotional() async {
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
}
