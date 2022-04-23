import 'package:flutter/material.dart';
import 'package:mapbox_navigation/screens/map_screen.dart';
import 'package:mapbox_navigation/screens/cicrle_screen.dart';
import 'package:mapbox_navigation/screens/feedback_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    const MapScreen(),
    const CircleScreen(),
    const FeedbackScreen()
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (selectedIndex) {
          setState(() {
            _index = selectedIndex;
          });
        },
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.map), label: 'Maps'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood), label: 'Circle'),
          BottomNavigationBarItem(
              icon: Icon(Icons.feedback), label: 'Feedback')
        ],
      ),
    );
  }
}
