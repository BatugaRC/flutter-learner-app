import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference courses =
      FirebaseFirestore.instance.collection("courses");
  Stream<QuerySnapshot> getSnapshot() {
    return courses.snapshots();
  }

  Future<void> addCourse(String title, int length, String? creator) async {
    await courses.add(
      {"title": title, "length": length, "creator": creator},
    );
  }

  Future<void> deleteCourse(String id) async {
    await courses.doc(id).delete();
  }
  Future<void> updateCourse(String id, String newTitle, int newLength) async {
    await courses.doc(id).update({
      "title": newTitle,
      "length": newLength,
  });
  }
}
