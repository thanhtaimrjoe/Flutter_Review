import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  Stream<QuerySnapshot> fetchRealtimeCategories() {
    return FirebaseFirestore.instance.collection('category').snapshots();
  }
}
