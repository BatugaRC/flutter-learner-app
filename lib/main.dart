import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/firebase_options.dart';
import 'package:learner_app/views/auth/welcome.dart';
import 'package:learner_app/views/home/add_course.dart';
import 'package:learner_app/views/auth/sign_in.dart';
import 'package:learner_app/views/auth/sign_up.dart';
import 'package:learner_app/views/home/card_list.dart';
import 'package:learner_app/views/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const Welcome(),
      routes: {
        "/welcome/":(context) => const Welcome(),
        "/signup/": (context) => const SignUp(),
        "/signin/": (context) => const SignIn(),
        "/home/": (context) => const Home(),
        "/addcourse/":(context) => const AddCourse(),
        "/cardlist/":(context) => FirestoreListView(),
      },
    );
  }
}

