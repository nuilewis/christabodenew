import 'package:christabodenew/models/message_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_base_service.dart';

class MessagesHiveService extends HiveService {
  final String _boxName = "messagesBox";
  final String _likedBoxName = "likedMessagesBox";

  Future<Box> openBox() async {
    Box box = await Hive.openBox(_boxName);
    return box;
  }

  Future<Box> openLikedBox() async {
    Box box = await Hive.openBox(_likedBoxName);
    return box;
  }

  Future<List<Message>> getData(Box box) async {
    if (box.values.isNotEmpty) {
      return box.values.toList().cast<Message>();
    } else {
      return <Message>[];
    }
  }

  Future<void> addMessages(Box box, List<Message> prayers) async {
    await box.put(_boxName, prayers);
  }

  Future<void> addLikedMessages(Box box, List<Message> prayers) async {
    await box.put(_likedBoxName, prayers);
  }

  Future<void> clearMessages(Box box) async {
    await box.clear();
  }
}
