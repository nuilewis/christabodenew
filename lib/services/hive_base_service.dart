import 'package:christabodenew/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HiveService {
  Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(DevotionalAdapter());
    Hive.registerAdapter(PrayerAdapter());
    Hive.registerAdapter(EventAdapter());
    Hive.registerAdapter(SettingsAdapter());
    Hive.registerAdapter(HymnAdapter());
    Hive.registerAdapter(UnsplashImageAdapter());
  }
}
