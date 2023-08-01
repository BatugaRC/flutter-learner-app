import 'package:flutter/material.dart';
import 'package:learner_app/services/database.dart';

class ColorBox extends StatelessWidget {
  final Color color;
  final bool isChosen;
  final int index;
  const ColorBox(
      {super.key,
      required this.color,
      required this.isChosen,
      required this.index});

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    if (isChosen) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 70,
          color: color,
          child: const Icon(Icons.check, color: Colors.white, size: 40,),
        ),
      ); 
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            db.changeColor(index);
          },
          child: Container(
            height: 70,
            color: color,
          ),
        ),
      );
    }
  }
}
