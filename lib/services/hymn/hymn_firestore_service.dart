import 'package:christabodenew/services/firestore_base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HymnFireStoreService extends FirestoreService {
  Future<QuerySnapshot> getHymns() async {
    QuerySnapshot<Map<String, dynamic>> result =
        await firestore.collection("hymn").get();
    return result;
  }
}
