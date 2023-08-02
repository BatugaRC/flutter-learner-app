// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';
import 'package:learner_app/utilities/creator_checker.dart';
import 'package:learner_app/utilities/show_error_dialog.dart';
import 'package:learner_app/views/comments/comments_view.dart';

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

    return FutureBuilder<String>(
      future: db.getCreatorName(creator),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Colors.black87,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Colors.black87,
            ),
            body: const Center(
              child: Text("Error fetching creator name"),
            ),
          );
        } else {
          final creatorName = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Colors.black87,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                    height: 120,
                  ),
                      const Text(
                        "This course is created by",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        creatorName!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool isCreator = checkCreator(creator);
                      if (isCreator) {
                        showErrorDialog(
                            context, "You can't enroll your own course");
                      } else {
                        bool result = await db.enroll(docId, uid);
                        if (!result) {
                          showErrorDialog(context,
                              "You are already enrolled in this course");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      fixedSize: const Size(150, 75),
                    ),
                    child: const Text(
                      "Enroll",
                      style: TextStyle(
                        fontSize: 27,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) {
                          return CommentsView(title: title, courseId: docId);
                        },),
                      );
                    },
                    label: const Text(
                      "See the comments for this course",
                      style: TextStyle(color: Colors.black87, fontSize: 15),
                    ), icon: const Icon(Icons.comment, color: Colors.black87,),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text("You have to enroll in this course to comment."),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
