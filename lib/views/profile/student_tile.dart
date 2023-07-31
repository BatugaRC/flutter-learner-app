import 'package:flutter/material.dart';
import 'package:learner_app/utilities/random_color.dart';

class StudentTile extends StatelessWidget {
  final String? username;
  final String? email;
  const StudentTile({super.key, required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    Color color = getRandomColor();
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: Text(
            username![0].toUpperCase(),
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
      title: Text(username!),
      subtitle: Text(email!),
    );
  }
}
