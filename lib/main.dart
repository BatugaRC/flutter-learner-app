import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learner_app/firebase_options.dart';
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
        "/signup/": (context) => const SignUp(),
        "/signin/": (context) => const SignIn(),
        "/home/": (context) => const Home(),
        "/addcourse/":(context) => const AddCourse(),
        "/cardlist/":(context) => FirestoreListView(),
      },
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 120.0,
          ),
          const Text(
            "Welcome to",
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(200, 0, 0, 0)),
          ),
          const Text(
            "Learner",
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(200, 0, 0, 0)),
          ),
          const SizedBox(
            height: 100.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  fixedSize: const Size(150.0, 75.0),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/signup/",
                    (route) => false,
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 31.24,
                      color: Color.fromARGB(223, 255, 255, 255)),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  fixedSize: const Size(150.0, 75.0),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/signin/",
                    (route) => false,
                  );
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: 31.24,
                      color: Color.fromARGB(223, 255, 255, 255)),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
