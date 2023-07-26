// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:learner_app/views/home/add_course.dart';
import 'package:learner_app/views/home/card_list.dart';

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
  ];
  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgets.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
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
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          _onItemTapped(value);
        },
      ),
    );
  }
}
