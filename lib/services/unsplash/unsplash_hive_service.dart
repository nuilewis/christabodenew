import 'package:christabodenew/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../hive_base_service.dart';

class UnsplashHiveService extends HiveService {
  final String _boxName = "unsplashBox";

  Future<Box> openBox() async {
    Box box = await Hive.openBox(_boxName);
    return box;
  }

  Future<List<UnsplashImage>> getData(Box box) async {
    if (box.values.isNotEmpty) {
      return box.values.first.toList().cast<UnsplashImage>();
    } else {
      return <UnsplashImage>[];
    }
  }

  Future<void> addImage(Box box, List<UnsplashImage> images) async {
    await box.put(_boxName, images);
  }

  Future<void> clearImage(Box box) async {
    await box.clear();
  }
}
