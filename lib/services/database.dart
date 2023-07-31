// ignore_for_file: unused_local_variable, avoid_function_literals_in_foreach_calls, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  CollectionReference courses =
      FirebaseFirestore.instance.collection("courses");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  String? uid = FirebaseAuth.instance.currentUser?.uid;


  Stream<QuerySnapshot> getCourses() {
    return courses.snapshots();
  }

  Future<void> addCourse(String title, int length, String? creator) async {
    DocumentReference docRef = await courses.add(
      {"title": title, "length": length, "creator": creator, "students": []},
    );
    String docId = docRef.id;
    users.doc(uid).update({
      "createdCourses": FieldValue.arrayUnion([docId])
    });
  }
  
  Future<DocumentSnapshot?> getCourse(String uid) {
    return courses.doc(uid).get();
  }

  Future<void> deleteCourse(String id) async {
    
    await courses.doc(id).delete();
    
    final userSnapshot = await FirebaseFirestore.instance
    .collection("users")
    .where("enrolledCourses", arrayContains: id)
    .get();
    final batch = FirebaseFirestore.instance.batch();
    DocumentReference userDoc = users.doc(uid);
    userDoc.update({
      "createdCourses": FieldValue.arrayRemove([id]),
    });

    userSnapshot.docs.forEach((doc) { 
      final userRef = doc.reference;
      final List<String> courses = List<String>.from(doc.data()["enrolledCourses"]);
      courses.remove(id);
      batch.update(userRef, {"enrolledCourses": courses});
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
      "enrolledCourses": [],
      "createdCourses": [],
  });
  }

  Future<bool> enroll(String courseId, String? uid) async {
  
    DocumentSnapshot userSnapshot = await users.doc(uid).get();
    DocumentReference courseRef = courses.doc(courseId);
    Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
    List<dynamic> enrolledCourses = userData?['enrolledCourses'] ?? [];
    if (enrolledCourses.contains(courseId)) {
      return false;
    } else {
    await users.doc(uid).update({
      "enrolledCourses": FieldValue.arrayUnion([courseId])
      });
    await courseRef.update({
      "students": FieldValue.arrayUnion([uid])
    });
      return true;
    } 
  }

  Stream<DocumentSnapshot> getUserData (String? uid) {
    return users.doc(uid).snapshots();
  }

  Future<void> changeUsername (String? newUsername, String uid) async {
    DocumentReference user = users.doc(uid);
    user.update({
      "username" : newUsername
    });

}

  Future<void> unenroll (String? uid, String courseId) async {
    DocumentReference user = users.doc(uid);
      await user.update({
      "enrolledCourses": FieldValue.arrayRemove([courseId])
    });
    await courses.doc(courseId).update({
      "students": FieldValue.arrayRemove([uid])
    });
  }
  Future<String> getCreatorName (String? creatorId) async {
      DocumentSnapshot docSnapshot = await users.doc(creatorId).get();
      final String creatorName = docSnapshot.get("username");
      return creatorName;
    }
  Stream<DocumentSnapshot> getCourseData (String? courseId) {
    return courses.doc(courseId).snapshots();
  }
  Future<DocumentSnapshot> getUser (String uid) {
    return users.doc(uid).get();
  }
}
