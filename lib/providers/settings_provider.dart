import 'package:christabodenew/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../core/core.dart';
import '../models/settings_model.dart';


class SettingsProvider extends ChangeNotifier {
  final SettingsRepository settingsRepository;
  AppState state = AppState.initial;
  String errorMessage = "";
  Settings userSettings = const Settings(isDarkMode: false, fontSize: 14);

  SettingsProvider(this.settingsRepository);

  Future<void> getSettings() async {
    Either<Failure, Settings?> response =
        await settingsRepository.getSettings();

    response.fold((failure) {
      state = AppState.error;
      errorMessage = failure.errorMessage ??
          "An error occurred while trying to get your preferences";
    }, (settings) {
      state = AppState.success;
      userSettings =
          settings ?? const Settings(isDarkMode: false, fontSize: 14);
    });

    notifyListeners();
  }

  Future<void> updateSettings(Settings settings) async {
    Either<Failure, void> response =
        await settingsRepository.updateSettings(settings);

    response.fold((failure) {
      state = AppState.error;
      errorMessage = failure.errorMessage ??
          "An error occurred while trying to get your preferences";
    }, (success) {
      state = AppState.success;
    });
    getSettings();
  }

  Future<void> clearSettings() async {
    Either<Failure, void> response = await settingsRepository.clearSettings();

    response.fold((failure) {
      state = AppState.error;
      errorMessage = failure.errorMessage ??
          "An error occurred while trying to clear your preferences";
    }, (success) {
      state = AppState.success;
    });
    notifyListeners();
  }
}
