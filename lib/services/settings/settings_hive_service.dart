import 'package:christabodenew/models/settings_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_base_service.dart';

class SettingsHiveService extends HiveService {
  final String _boxName = "settingsBox";

  Future<Box> openBox() async {
    Box box = await Hive.openBox(_boxName);
    return box;
  }

  Future<Settings?> getData(Box box) async {
    Settings gottenSettings = box.values.first;
    return gottenSettings;
  }

  Future<void> addSettings(Box box, Settings settings) async {
    await box.put(_boxName, settings);
  }

  Future<void> clearSettings(Box box) async {
    await box.clear();
  }
}
