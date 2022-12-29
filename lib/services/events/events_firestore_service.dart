import 'package:christabodenew/services/firestore_base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsFirestoreService extends FirestoreService {
  Future<QuerySnapshot> getEvents() async {
    ///To ensure the app will auto update when the year changes
    final String currentYear = DateTime.now().year.toString();

    try {
    QuerySnapshot<Map<String, dynamic> >result = await firestore
          .collection(currentYear)
          .doc("events")
          .collection("events").get();
      return result;
    } on FirebaseException {
      rethrow;
    }
  }
}
