import 'package:christabodenew/models/message_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_base_service.dart';

class MessagesHiveService extends HiveService {
  final String boxName = "messagesBox";

  Future<Box> openBox() async {
    Box box = await Hive.openBox(boxName);
    return box;
  }

  @override
  Future<void> initHive() async {
    super.initHive();
    Hive.registerAdapter(MessageAdapter());
  }

  Future<List<Message>> getData(Box box) async {
    if (box.values.isNotEmpty) {
      return box.values.toList().cast<Message>();
    } else {
      return <Message>[];
    }
  }

  Future<void> addPrayers(Box box, List<Message> prayers) async {
    await box.put(boxName, prayers);
  }

  Future<void> clearPrayers(Box box) async {
    await box.clear();
  }
}
