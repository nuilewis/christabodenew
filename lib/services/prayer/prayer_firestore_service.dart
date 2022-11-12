import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerFireStoreService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getPrayer() async {
    try {
      ///Todo: implement firestore reading.
    } on FirebaseException {
      rethrow;
    }
  }
}
