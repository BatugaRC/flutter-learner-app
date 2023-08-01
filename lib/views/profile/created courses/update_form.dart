// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../services/database.dart';

class UpdateForm extends StatefulWidget {
  final String docId;
  final String creator;
  final String name;
  final int length;

  const UpdateForm({Key? key, required this.docId, required this.creator, required this.name, required this.length}) : super(key: key);

  @override
  State<UpdateForm> createState() => _UpdateFormState(docId, creator, name, length);
}


class _UpdateFormState extends State<UpdateForm> {
  final DatabaseService db = DatabaseService();
  late final TextEditingController _title;
  late final TextEditingController _length;
  final String docId;
  final String creator;
  final String name;
  int length;

  _UpdateFormState(this.docId, this.creator, this.name, this.length);


  @override
  void initState() {
    _title = TextEditingController();
    _length = TextEditingController();
    _title.text = name;
    _length.text = length.toString();
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _length.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _title,
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
                labelText: 'New Course name',
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                hintText: 'Enter the new course name',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            TextFormField(
              controller: _length,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
                labelText: 'New Length',
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                hintText: 'Enter the new course length',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 35.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 218, 203, 62),
                fixedSize: const Size(120, 50),
              ),
              onPressed: () {
                final title = _title.text;
                final length = _length.text;
                db.updateCourse(docId, title, int.parse(length));
              },
              child: const Text(
                "Update",
                style: TextStyle(
                  fontSize: 23.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}