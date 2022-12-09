import 'package:christabodenew/services/firestore_base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DevotionalFirestoreService extends FirestoreService {
  Future<QuerySnapshot> getDevotionals({String? year}) async {
    ///To ensure the app will auto update when the year changes
    final String currentYear = DateTime.now().year.toString();

    try {
      QuerySnapshot<Map<String, dynamic>> result = await firestore
          .collection(year ?? currentYear)
          .doc("devotional")
          .collection("devotional")
          .get();
      return result;
    } on FirebaseException {
      rethrow;
    }
  }
}
