// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, unused_element, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:learner_app/services/auth_service.dart';
import 'package:learner_app/views/home/add_course.dart';
import 'package:learner_app/views/home/card_list.dart';
import 'package:learner_app/views/profile/profile_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _selectedIndex = 0;
  static List<Widget> _widgets = <Widget>[
    FirestoreListView(),
    AddCourse(),
    ProfileView(),
  ];
  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 250, 250),
      body: _widgets.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(189, 133, 133, 133),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
            ),
            label: "Create Course",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        selectedItemColor: Colors.black87,
        unselectedItemColor: Color.fromARGB(226, 255, 255, 255),
        currentIndex: _selectedIndex,
        onTap: (value) {
          _onItemTapped(value);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
        onPressed: () async {
          String result = await _auth.signOut();
          if (result == "0") {
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/welcome/",
              (route) => false,
            );
          } else {
            print(result);
          }
        },
      ),
    );
  }
}
