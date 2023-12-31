// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';

class ChangeUsernameForm extends StatefulWidget {
  final String username;
  const ChangeUsernameForm({super.key, required this.username});

  @override
  State<ChangeUsernameForm> createState() => _ChangeUsernameFormState(username);
}

class _ChangeUsernameFormState extends State<ChangeUsernameForm> {
  final String oldUsername;
  late final TextEditingController _username;

  _ChangeUsernameFormState(this.oldUsername);

  @override
  void initState() {
    _username = TextEditingController();
    _username.text = oldUsername;
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 60.0,
          horizontal: 60.0,
        ),
      child: Form(
        child: Column(
          children: [
            TextField(
              controller: _username,
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
                labelText: 'New Username',
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                hintText: 'Enter your new username',
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
                String username = _username.text;
                db.changeUsername(username, uid);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 218, 203, 62),
                fixedSize: Size(130, 55)
              ),
              child: Text(
                "Change",
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
