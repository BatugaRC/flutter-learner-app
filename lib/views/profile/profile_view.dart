// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';
import 'package:learner_app/views/profile/change_username_form.dart';
import 'package:learner_app/views/profile/created_courses.dart';
import 'package:learner_app/views/profile/enrolled_courses.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseService db = DatabaseService();

    return StreamBuilder<DocumentSnapshot>(
      stream: db.getUserData(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text("Error fetching data: ${snapshot.error}");
        }
        if (!snapshot.hasData) {
          return Text("No data available");
        }
        final data = snapshot.data;
        final String username = data!["username"];
        final String email = data["email"];
        List<dynamic> enrolledCourses = data["enrolledCourses"];
        List<dynamic> createdCourses = data["createdCourses"];
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              ListTile(
                title: Text("Username"),
                subtitle: Text(username),
                trailing: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ChangeUsernameForm();
                      },
                    );
                  },
                  child: Text(
                    "Change Username",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text("Email"),
                subtitle: Text(email),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EnrolledCourses(
                              enrolledCourses: enrolledCourses,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        fixedSize: Size(
                          150,
                          45,
                        ),
                      ),
                      child: Text("Enrolled Courses"),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreatedCourses(
                              createdCourses: createdCourses,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        fixedSize: Size(
                          150,
                          45,
                        ),
                      ),
                      child: Text(
                        "Created Courses",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
