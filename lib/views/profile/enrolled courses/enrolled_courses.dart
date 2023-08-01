// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/views/profile/enrolled%20courses/enrolled_course_card.dart';

import '../../../services/database.dart';

class EnrolledCourses extends StatelessWidget {
  final List<dynamic>? enrolledCourses;
  const EnrolledCourses({super.key, required this.enrolledCourses});

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    if (enrolledCourses!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Enrolled Courses",
          ),
          backgroundColor: Colors.black87,
        ),
        body: Center(
          child: Text(
            "You have not enrolled in any courses.",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enrolled Courses",
        ),
        backgroundColor: Colors.black87,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: enrolledCourses?.length,
        itemBuilder: (BuildContext context, int index) {
          var currentCourseId = enrolledCourses?[index];
          if (currentCourseId == null || currentCourseId == "") {
            return const SizedBox.shrink();
          }
          return FutureBuilder<DocumentSnapshot?>(
            future: db.getCourse(currentCourseId),
            builder: (context, courseSnapshot) {
              if (courseSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (courseSnapshot.hasError) {
                return Center(child: Text('Error: ${courseSnapshot.error}'));
              }
              if (!courseSnapshot.hasData || !courseSnapshot.data!.exists) {
                return const Text("Course data not found");
              }

              Map<String, dynamic> courseData =
                  courseSnapshot.data!.data() as Map<String, dynamic>;
              String title = courseData['title'];
              String creator = courseData['creator'];
              int length = courseData['length'];

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: EnrolledCourseCard(
                  title: title,
                  creator: creator,
                  docId: currentCourseId,
                  length: length,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
