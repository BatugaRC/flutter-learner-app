// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';
import 'package:learner_app/utilities/creator_checker.dart';
import 'package:learner_app/utilities/show_error_dialog.dart';

import '../../utilities/show_bottom_sheet.dart';

class CardView extends StatelessWidget {
  final String title;
  final int length;
  final String? creator;
  final String docId;
  const CardView(
      {super.key,
      required this.title,
      required this.length,
      required this.creator,
      required this.docId});

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = DatabaseService();
    final uid = FirebaseAuth.instance.currentUser?.uid;
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
              onPressed: () {
                bool isCreator = checkCreator(creator);
                if (isCreator) {
                  showSettingsPanel(context, docId, creator);
                } else {
                  showErrorDialog(context, "Only the creator can update the course");
                }
                
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 218, 203, 62),
                  fixedSize: const Size(150, 75)),
              child: const Text(
                "Update",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                bool isCreator = checkCreator(creator);
                if (isCreator) {
                await db.deleteCourse(docId);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/home/",
                  (route) => false,
                );
              } else {
                showErrorDialog(context, "Only the creator can delete the course");
              }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, fixedSize: const Size(150, 75)),
              child: const Text(
                "Delete",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                bool isCreator = checkCreator(creator);
                if (isCreator) {
                  showErrorDialog(context, "You can't enroll your own course");
                } else {
                 bool result = await db.enroll(docId, uid);
                 if (!result) {
                  showErrorDialog(context, "You are already enrolled in this course");
                 }
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, fixedSize: const Size(150, 75)),
              child: const Text(
                "Enroll",
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
