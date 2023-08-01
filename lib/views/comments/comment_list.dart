import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';
import 'package:learner_app/utilities/get_color.dart';
import 'package:learner_app/views/comments/comment_box.dart';

import 'owned_comment_box.dart';

class CommentList extends StatelessWidget {
  final String courseId;

  const CommentList({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    return StreamBuilder<DocumentSnapshot>(
        stream: db.getCourseData(courseId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final data = snapshot.data;
          List<dynamic> commentIds = data?["comments"];

          return ListView.builder(
            itemCount: commentIds.length,
            itemBuilder: (BuildContext context, int index) {
              final String commentId = commentIds[index];
              return FutureBuilder(
                future: db.getComment(commentId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final data = snapshot.data;
                  final String content = data?["content"];
                  final String commenterId = data?["commenter"];
                  return FutureBuilder(
                    future: db.getUser(commenterId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      final commenter = snapshot.data?["username"];
                      final int colorIndex = snapshot.data?["color"];
                      final Color color = getColor(colorIndex); 
                      if (commenterId == FirebaseAuth.instance.currentUser!.uid) {
                      return OwnedCommentBox(commenter: commenter, content: content, commentId: commentId, courseId: courseId, color: color);
                      } else {
                        return CommentBox(commenter: commenter, content: content, commentId: commentId, color: color);
                      }
                    },
                  );
                },
              );
            },
          );
        });
  }
}
