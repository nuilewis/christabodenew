import 'package:hive_flutter/hive_flutter.dart';

import '../../models/hymn_model.dart';
import '../hive_base_service.dart';

class HymnHiveService extends HiveService {
  final String _boxName = "hymnBox";

  Future<Box> openBox() async {
    Box box = await Hive.openBox(_boxName);
    return box;
  }

  Future<List<Hymn>> getData(Box box) async {
    if (box.values.isNotEmpty) {
      return box.values.first.toList().cast<Hymn>();
    } else {
      return <Hymn>[];
    }
  }

  Future<void> addHymn(Box box, List<Hymn> hymns) async {
    await box.put(_boxName, hymns);
  }

  Future<void> clearHymn(Box box) async {
    await box.clear();
  }
}
