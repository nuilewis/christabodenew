import 'package:christabodenew/services/firestore_base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerFireStoreService extends FirestoreService {
  Future<QuerySnapshot> getPrayers() async {

      QuerySnapshot<Map<String, dynamic>> result =
          await firestore.collection("prayer").get();
      return result;

  }
}
