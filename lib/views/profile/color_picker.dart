// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';
import 'package:learner_app/views/profile/color_box.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];
    return StreamBuilder<DocumentSnapshot>(
        stream: db.getUserData(FirebaseAuth.instance.currentUser?.uid),
        builder: (context, snapshot) {
          final data = snapshot.data;
          int? chosenColorIndex = data?["color"];
          return Padding(
              padding: EdgeInsets.fromLTRB(140, 4, 140, 4),
              child: ListView.builder(
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  Color color = colors[index];
                  bool isChosen = chosenColorIndex == index;
                  return ColorBox(color: color, isChosen: isChosen, index: index,);
                },
              ));
        });
  }
}
