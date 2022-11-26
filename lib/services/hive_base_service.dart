import 'package:christabodenew/models/devotional_model.dart';
import 'package:christabodenew/models/prayer_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/event_model.dart';
import '../models/message_model.dart';

class HiveService {
  Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(DevotionalAdapter());
    Hive.registerAdapter(PrayerAdapter());
    Hive.registerAdapter(EventAdapter());
  }
}
