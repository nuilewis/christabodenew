import 'package:hive_flutter/hive_flutter.dart';

import '../../models/prayer_model.dart';
import '../hive_base_service.dart';

class PrayerHiveService extends HiveService {
  final String boxName = "prayerBox";

  Future<Box> openBox() async {
    Box box = await Hive.openBox(boxName);
    return box;
  }

  Future<List<Prayer>> getData(Box box) async {
    if (box.values.isNotEmpty) {
      return box.values.toList().cast<Prayer>();
    } else {
      return <Prayer>[];
    }
  }

  Future<void> addPrayers(Box box, List<Prayer> prayers) async {
    await box.put(boxName, prayers);
  }

  Future<void> clearPrayers(Box box) async {
    await box.clear();
  }
}
