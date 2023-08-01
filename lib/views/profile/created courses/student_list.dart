// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';
import 'package:learner_app/utilities/get_color.dart';
import 'package:learner_app/views/profile/created%20courses/student_tile.dart';

class StudentList extends StatelessWidget {
  String? docId;
  String? title;
  StudentList({super.key, required this.docId, required this.title});

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    return Scaffold(
      appBar: AppBar(
        title: Text("Students of $title"),
        backgroundColor: Colors.black87,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: db.getCourseData(docId),
        builder: (context, snapshot) {
          final data = snapshot.data;
          List<dynamic>? students = data?["students"];
          return ListView.builder(
            itemCount: students?.length,
            itemBuilder: (context, index) {
              final String? uid = students?[index];
              return FutureBuilder(
                future: db.getUser(uid!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } 
                  final data = snapshot.data;
                  String? username = data?["username"];
                  String? email = data?["email"];
                  int colorIndex = data?["color"];
                  Color color = getColor(colorIndex);
                  return StudentTile(username: username, email: email, color: color);
                  
                },
              );
            },
          );
        },
      ),
    );
  }
}
