import 'package:christabodenew/models/event_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_base_service.dart';

class EventsHiveService extends HiveService {
  final String boxName = "eventsBox";

  Future<Box> openBox() async {
    Box box = await Hive.openBox(boxName);
    return box;
  }

  Future<List<Event>> getData(Box box) async {
    if (box.values.isNotEmpty) {
      return box.values.first.toList().cast<Event>();
    } else {
      return <Event>[];
    }
  }

  Future<void> addEvents(Box box, List<Event> events) async {
    await box.put(boxName, events);
  }

  Future<void> clearEvents(Box box) async {
    await box.clear();
  }
}
