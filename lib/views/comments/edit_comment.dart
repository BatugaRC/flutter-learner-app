// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';

class EditCommentForm extends StatefulWidget {
  final String commentId;
  final String comment;
  const EditCommentForm({super.key, required this.commentId, required this.comment});

  @override
  State<EditCommentForm> createState() => _EditCommentFormState(commentId, comment);
}

class _EditCommentFormState extends State<EditCommentForm> {
  final String commentId;
  final String comment;
  late final TextEditingController _comment;

  _EditCommentFormState(this.commentId, this.comment);

  @override
  void initState() {
    _comment = TextEditingController();
    _comment.text = comment;
    super.initState();
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }
   

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 60.0,
          horizontal: 60.0,
        ),
      child: Form(
        child: Column(
          children: [
            TextField(
              controller: _comment,
              
              enableSuggestions: false,
              autocorrect: false,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                ),
                labelText: 'Comment',
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                hintText: 'Edit your comment',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
              onPressed: () {
                String comment = _comment.text;
                db.editComment(commentId, comment);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                fixedSize: Size(130, 55)
              ),
              child: Text(
                "Edit",
                style: TextStyle(
                  fontSize: 25
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
