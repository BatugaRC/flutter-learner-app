// ignore_for_file: no_logic_in_create_state, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';

class CommentField extends StatefulWidget {
  final String? docId;
  const CommentField({super.key, required this.docId});

  @override
  State<CommentField> createState() => _CommentFieldState(docId: docId);
}

class _CommentFieldState extends State<CommentField> {
  final String? docId;
  late final TextEditingController _comment;

  _CommentFieldState({required this.docId});

  @override
  void initState() {
    _comment = TextEditingController();
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
    return Form(
      child: TextField(
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
          hintText: 'Write your comment here',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              String comment = _comment.text;
              db.createComment(comment, docId);
              setState(() {
                _comment.text = "";
              });
            },
          ),
        ),
      ),
    );
  }
}
