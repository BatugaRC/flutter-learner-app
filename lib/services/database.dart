// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference courses =
      FirebaseFirestore.instance.collection("courses");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  Stream<QuerySnapshot> getCourses() {
    return courses.snapshots();
  }

  Future<void> addCourse(String title, int length, String? creator) async {
    await courses.add(
      {"title": title, "length": length, "creator": creator},
    );
  }
  Future<DocumentSnapshot?> getCourse(String uid) {
    return courses.doc(uid).get();
  }

  Future<void> deleteCourse(String id) async {
    await courses.doc(id).delete();
    final userSnapshot = await FirebaseFirestore.instance
    .collection("users")
    .where("courses", arrayContains: id)
    .get();
    final batch = FirebaseFirestore.instance.batch();
    userSnapshot.docs.forEach((doc) { 
      final userRef = doc.reference;
      final List<String> courses = List<String>.from(doc.data()["courses"]);
      courses.remove(id);
      batch.update(userRef, {"courses": courses});
    });
    batch.commit();
    
  }

  Future<void> updateCourse(String id, String newTitle, int newLength) async {
    await courses.doc(id).update(
      {
        "title": newTitle,
        "length": newLength,
      },
    );
  }
  Future<void> createUser(String uid, String email, String username) async {
    await users.doc(uid).set({
      "username": username,
      "email": email,
      "courses": [],
  });
  }
  Future<bool> enroll(String courseId, String? uid) async {
  
    DocumentSnapshot userSnapshot = await users.doc(uid).get();
    Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
    List<dynamic> courses = userData?['courses'] ?? [];
    if (courses.contains(courseId)) {
      return false;
    } else {
    await users.doc(uid).update({
      "courses": FieldValue.arrayUnion([courseId])
    
      });
      return true;
    } 
  }
  Stream<DocumentSnapshot> getUserData (String? uid) {
    return users.doc(uid).snapshots();
  }
}
