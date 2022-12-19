import 'package:christabodenew/core/errors/failure.dart';
import 'package:christabodenew/services/settings/settings_hive_service.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/settings_model.dart';

abstract class SettingsRepository {
  Future<Either<Failure, void>> updateSettings(Settings settings);
  Future<Either<Failure, void>> clearSettings();
  Future<Either<Failure, Settings?>> getSettings();
}

class SettingsRepositoryImplementation implements SettingsRepository {
  final SettingsHiveService settingsHiveService;

  SettingsRepositoryImplementation(this.settingsHiveService);
  @override
  Future<Either<Failure, void>> updateSettings(Settings settings) async {
    final Box settingsBox = await settingsHiveService.openBox();
    try {
      await settingsHiveService.addSettings(settingsBox, settings);
      return Right(Future.value());
    } catch (e) {
      rethrow;
      //   return const Left(LocalStorageFailure(
      //       errorMessage: "An error occurred while updating your preferences"));
    }
  }

  @override
  Future<Either<Failure, Settings?>> getSettings() async {
    final Box settingsBox = await settingsHiveService.openBox();
    try {
      final Settings? userSettings =
          await settingsHiveService.getData(settingsBox);
      return Right(userSettings);
    } catch (e) {
      return const Left(LocalStorageFailure(
          errorMessage: "An error occurred while getting your preferences"));
    }
  }

  @override
  Future<Either<Failure, void>> clearSettings() async {
    final Box settingsBox = await settingsHiveService.openBox();
    try {
      await settingsHiveService.clearSettings(settingsBox);
      return Right(Future.value());
    } catch (e) {
      return const Left(LocalStorageFailure(
          errorMessage: "An error occured while clearing your preferences"));
    }
  }
}
