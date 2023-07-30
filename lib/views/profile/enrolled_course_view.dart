// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';


class EnrolledCourseView extends StatelessWidget {
  final String title;
  final int length;
  final String creator;
  final String docId;
  const EnrolledCourseView(
      {super.key,
      required this.title,
      required this.length,
      required this.creator,
      required this.docId});

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = DatabaseService();
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await db.unenroll(uid, docId);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, fixedSize: const Size(150, 75)),
              child: const Text(
                "Discard",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
