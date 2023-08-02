// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../services/database.dart';
import 'created_course_card.dart';

class CreatedCourses extends StatelessWidget {
  final List<dynamic>? createdCourses;
  const CreatedCourses({super.key, required this.createdCourses});

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    if (createdCourses!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Created Courses",
          ),
          backgroundColor: Colors.black87,
        ),
        body: Center(
           child: Column(
            
            children: [
              SizedBox(
                height: 80,
              ),
              Image.network(
                "https://thenounproject.com/api/private/icons/640550/edit/?backgroundShape=SQUARE&backgroundShapeColor=%23000000&backgroundShapeOpacity=0&exportSize=752&flipX=false&flipY=false&foregroundColor=%23000000&foregroundOpacity=1&imageFormat=png&rotation=0",
              ),
              Text(
                "You have not created any courses.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Created Courses",
        ),
        backgroundColor: Colors.black87,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: createdCourses?.length,
        itemBuilder: (BuildContext context, int index) {
          var currentCourseId = createdCourses?[index];
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
                child: CreatedCourseCard(
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
