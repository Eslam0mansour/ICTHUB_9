import 'package:flutter/material.dart';
import 'package:icthubx/screens/counter_screen.dart';
import 'package:icthubx/screens/list_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  List<Widget> listScreens = [
    const ListScreen(),
    const CounterScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
            ),
            label: 'counter',
          ),
        ],
      ),
    );
  }
}
