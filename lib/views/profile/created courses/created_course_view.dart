// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';
import 'package:learner_app/views/profile/student_list.dart';
import 'update_form.dart';

class CreatedCourseView extends StatelessWidget {
  final String title;
  final int length;
  final String creator;
  final String docId;
  const CreatedCourseView(
      {super.key,
      required this.title,
      required this.length,
      required this.creator,
      required this.docId});

  @override
  Widget build(BuildContext context) {
    final DatabaseService db = DatabaseService();
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
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 60.0,
                      ),
                      child: UpdateForm(
                        docId: docId,
                        creator: creator,
                        name: title,
                        length: length,
                      ),
                    );
                  },
                );
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
                await db.deleteCourse(docId);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/home/",
                  (route) => false,
                );
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
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentList(
                      docId: docId,
                      title: title,
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.black87),
              child: const Text("See the students of this course"),
            )
          ],
        ),
      ),
    );
  }
}
