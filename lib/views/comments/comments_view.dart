import 'package:flutter/material.dart';
import 'package:learner_app/views/comments/comment_list.dart';

class CommentsView extends StatelessWidget {
  final String title;
  final String courseId;
  const CommentsView({super.key, required this.title, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments for $title"),
        backgroundColor: Colors.black87,
      ),
      body: CommentList(courseId: courseId,),
    );
  }
}