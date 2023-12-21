import 'package:christabodenew/services/firestore_base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HymnFireStoreService extends FirestoreService {
  Future<DocumentSnapshot> getHymns() async {
    print("sending hymn request to firestore");
    DocumentSnapshot<Map<String, dynamic>> result =
        await firestore.collection("hymn").doc("hymn").get();
    return result;
  }
}
