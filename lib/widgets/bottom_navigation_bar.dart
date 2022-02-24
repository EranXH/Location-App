import 'package:flutter/material.dart';

// the Bottom Navigation Bar is used in both pages to route the user between them
class BottomBar extends StatelessWidget {
  final int currentIndex;

  const BottomBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_view_month_outlined),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_location),
          label: 'Add Location',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (int index) {
        if (index != currentIndex) {
          switch (index) {
            case 0:
              {
                Navigator.pushNamed(context, '/calendar');
              }
              break;

            case 1:
              {
                Navigator.pushNamed(context, '/add_form');
              }
              break;
          }
        }
      },
    );
  }
}
