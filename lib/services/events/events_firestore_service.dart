import 'package:christabodenew/services/firestore_base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsFirestoreService extends FirestoreService {
  Future<DocumentSnapshot> getEvents({String? year}) async {
    ///To ensure the app will auto update when the year changes
    final String currentYear = DateTime.now().year.toString();

    DocumentSnapshot<Map<String, dynamic> >result = await firestore
          .collection(year ?? currentYear)
          .doc("events").get();
      return result;

  }
}
