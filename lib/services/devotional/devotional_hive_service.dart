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
      ///Hive is storing the devotional as a List of list, therefore, all devotional
      ///items are in a List<Devotional>, which is stored in the first index of the the larger list
      ///
      /// SO we get the first item in the larger list, which is the list of devotional items
      /// before we then cast as a list of devotional items and output our result.
      return box.values.first.toList().cast<Devotional>();
    } else {
      return <Devotional>[];
    }
  }

  Future<void> addDevotional(Box box, List<Devotional> devotional) async {
    await box.put(boxName, devotional);
  }

  Future<void> clearDevotional(Box box) async {
    await box.clear();
  }
}
