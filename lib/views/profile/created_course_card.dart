import 'package:flutter/material.dart';
import 'created courses/created_course_view.dart';

class CreatedCourseCard extends StatelessWidget {
  final String title;
  final int length;
  final String creator;
  final String docId;

  const CreatedCourseCard(
      {super.key,
      required this.title,
      required this.length,
      required this.creator,
      required this.docId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatedCourseView(
            creator: creator,
            docId: docId,
            length: length,
            title: title,
          ),
        ),
      ),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Length: $length",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
