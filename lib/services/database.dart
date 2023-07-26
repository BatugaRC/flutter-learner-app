import 'package:cloud_firestore/cloud_firestore.dart';



class DatabaseService {
  CollectionReference courses = FirebaseFirestore.instance.collection("courses");
  Stream<QuerySnapshot> getSnapshot() {
    return courses.snapshots();
  }

  Future<void> addCourse(String title, int length) async {
    courses.add({
      "title": title,
      "length": length,
    });
  }

}