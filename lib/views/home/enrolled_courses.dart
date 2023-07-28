import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/database.dart';
import 'course_card.dart';

class EnrolledCourses extends StatelessWidget {
  const EnrolledCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<DocumentSnapshot>(
      stream: db.getUserData(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('User data not found'));
        }

        // User data is available, extract the courses field as a list
        Map<String, dynamic> userData =
            snapshot.data!.data() as Map<String, dynamic>;
        List<dynamic> enrolledCourses = userData['courses'] ?? [];

        if (enrolledCourses.isEmpty) {
          return const Center(child: Text('No enrolled courses found'));
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: enrolledCourses.length,
          itemBuilder: (BuildContext context, int index) {
            var currentCourseId = enrolledCourses[index];
            if (currentCourseId == null || currentCourseId == "") {
              return const SizedBox.shrink(); // Skip this item to avoid errors
            }
            return FutureBuilder<DocumentSnapshot?>(
              future: db.getCourse(currentCourseId),
              builder: (context, courseSnapshot) {
                if (courseSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (courseSnapshot.hasError) {
                  return Center(child: Text('Error: ${courseSnapshot.error}'));
                }
                if (!courseSnapshot.hasData ||
                    !courseSnapshot.data!.exists) {
                  return const Text("Course data not found");
                }

                Map<String, dynamic> courseData =
                    courseSnapshot.data!.data() as Map<String, dynamic>;
                String title = courseData['title'];
                String creator = courseData['creator'];
                int length = courseData['length'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CourseCard(
                    title: title,
                    creator: creator,
                    docId: currentCourseId,
                    length: length,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
