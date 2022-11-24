import 'package:christabodenew/models/devotional_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_base_service.dart';

class DevotionalHiveService extends HiveService {
  final String boxName = "devotionalBox";

  Future<Box> openBox() async {
    Box box = await Hive.openBox(boxName);
    return box;
  }

  @override
  Future<void> initHive() async {
    super.initHive();
    Hive.registerAdapter(DevotionalAdapter());
  }

  Future<List<Devotional>> getData(Box box) async {
    if (box.values.isNotEmpty) {
      return box.values.toList().cast<Devotional>();
    } else {
      return <Devotional>[];
    }
  }

  Future<void> addPrayers(Box box, List<Devotional> devotional) async {
    await box.put(boxName, devotional);
  }

  Future<void> clearPrayers(Box box) async {
    await box.clear();
  }
}
