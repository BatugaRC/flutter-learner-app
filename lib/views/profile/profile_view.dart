// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';
import 'package:learner_app/utilities/get_color.dart';
import 'package:learner_app/views/profile/change_username_form.dart';
import 'package:learner_app/views/profile/created%20courses/created_courses.dart';
import 'package:learner_app/views/profile/enrolled%20courses/enrolled_courses.dart';

import 'color_picker.dart';

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
        int colorIndex = data["color"];
        Color color = getColor(colorIndex);
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(context: context, builder: ((context) {
                          return ColorPicker();
                        }));
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                username[0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 36,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                    ),
                    Image.network(
                      "https://www.transparentpng.com/thumb/user/gray-user-profile-icon-png-fP8Q1P.png",
                      height: 50,
                      width: 50,
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text("Username"),
                subtitle: Text(username),
                trailing: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ChangeUsernameForm(
                          username: username,
                        );
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
                padding: EdgeInsets.fromLTRB(30, 130, 30, 0),
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
                          50,
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
                          50,
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
