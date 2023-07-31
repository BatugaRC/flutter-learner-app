import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learner_app/services/database.dart';

import '../../models/course_model.dart';
import 'course_card.dart';

class FirestoreListView extends StatelessWidget {
  FirestoreListView({super.key});
  final DatabaseService db = DatabaseService();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.getCourses(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
        List<FirestoreData> data = docs.map((doc) {
          return FirestoreData(
            title: doc.get('title') ?? '',
            length: doc.get('length') ?? '',
            docId: doc.id,
            creator: doc.get("creator") ?? '',
          );
        }).toList();
        if (data.length == 0) {
          return const Center(
            child: Text(
              "There are no any courses, yet.",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            FirestoreData cardData = data[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: CourseCard(
                title: cardData.title,
                length: cardData.length,
                creator: cardData.creator,
                docId: data[index].docId,
              ),
            );
          },
        );
      },
    );
  }
}
