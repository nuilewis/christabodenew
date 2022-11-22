import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerFireStoreService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getPrayers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> result =
          await fireStore.collection("prayer").get();
      return result;
    } on FirebaseException {
      rethrow;
    }
  }
}
