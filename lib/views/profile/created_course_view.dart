// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';
import '../../utilities/show_bottom_sheet.dart';

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
               
                  showSettingsPanel(context, docId, creator);
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
          ],
        ),
      ),
    );
  }
}
