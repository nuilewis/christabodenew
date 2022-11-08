import 'package:christabodenew/models/devotional_model.dart';
import 'package:christabodenew/repositories/devotional_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/errors/failure.dart';

enum DevotionalStatus { initial, submitting, success, error }

class DevotionalProvider extends ChangeNotifier {
  final DevotionalRepository devotionalRepository;
  DevotionalStatus status = DevotionalStatus.initial;
  String errorMessage = "";
  Devotional? todaysDevotional;

  DevotionalProvider({required this.devotionalRepository});

  Future<void> getCurrentDevotional() async {
    if (status == DevotionalStatus.submitting) return;

    Either<Failure, Devotional> response =
        await devotionalRepository.getCurrentDevotional();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occured while getting today's Devotional";
      status = DevotionalStatus.error;

      notifyListeners();
    }, (devotional) {
      todaysDevotional = devotional;
      status = DevotionalStatus.success;

      notifyListeners();
    });
  }

  Future<void> getNextDevotional() async {
    if (status == DevotionalStatus.submitting) return;
    Either<Failure, Devotional> response =
        await devotionalRepository.getNextDevotional();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occured while getting today's Devotional";
      status = DevotionalStatus.error;
      notifyListeners();
    }, (devotional) {
      todaysDevotional = devotional;
      status = DevotionalStatus.success;
      notifyListeners();
    });
  }

  Future<void> getPreviousDevotional() async {
    if (status == DevotionalStatus.submitting) return;

    Either<Failure, Devotional> response =
        await devotionalRepository.getPreviousDevotional();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occured while getting today's Devotional";
      status = DevotionalStatus.error;

      notifyListeners();
    }, (devotional) {
      todaysDevotional = devotional;
      status = DevotionalStatus.success;

      notifyListeners();
    });
  }

  Future<void> getDevotional() async {
    if (status == DevotionalStatus.submitting) return;

    Either<Failure, Devotional> response =
        await devotionalRepository.getDevotional();

    response.fold((failure) {
      errorMessage = failure.errorMessage ??
          "An error occured while getting today's Devotional";
      status = DevotionalStatus.error;

      notifyListeners();
    }, (devotional) {
      todaysDevotional = devotional;
      status = DevotionalStatus.success;

      notifyListeners();
    });
  }
}
