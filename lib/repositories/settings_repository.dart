import 'package:christabodenew/core/errors/failure.dart';
import 'package:christabodenew/services/settings/settings_hive_service.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/settings_model.dart';

class SettingsRepository {
  final SettingsHiveService settingsHiveService;

  SettingsRepository(this.settingsHiveService);

  Future<Either<Failure, void>> updateSettings(Settings settings) async {
    final Box settingsBox = await settingsHiveService.openBox();
    try {
      await settingsHiveService.addSettings(settingsBox, settings);
      return const Right(null);
    } catch (e) {

        return const Left(Failure(
            errorMessage: "An error occurred while updating your preferences"));
    }
  }

  Future<Either<Failure, Settings?>> getSettings() async {
    final Box settingsBox = await settingsHiveService.openBox();
    try {
      final Settings? userSettings =
          await settingsHiveService.getData(settingsBox);
      return Right(userSettings);
    } catch (e) {
      return const Left(Failure(
          errorMessage: "An error occurred while getting your preferences"));
    }
  }

  Future<Either<Failure, void>> clearSettings() async {
    final Box settingsBox = await settingsHiveService.openBox();
    try {
      await settingsHiveService.clearSettings(settingsBox);
      return const Right(null);
    } catch (e) {
      return const Left(Failure(
          errorMessage: "An error occurred while clearing your preferences"));
    }
  }
}
