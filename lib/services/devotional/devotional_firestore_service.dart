import 'package:christabodenew/services/firestore_base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DevotionalFirestoreService extends FirestoreService {
  Future<QuerySnapshot> getDevotionals() async {
    try {
      QuerySnapshot<Map<String, dynamic>> result =
          await firestore.collection("devotional").get();
      return result;
    } on FirebaseException {
      rethrow;
    }
  }
}
