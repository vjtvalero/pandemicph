import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  NavBar(
    this.changePage,
    this.currentPage,
  );

  final int currentPage;
  final changePage;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.place),
          title: Text('Tracker'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          title: Text('Menu'),
        ),
      ],
      currentIndex: widget.currentPage,
      onTap: (i) {
        widget.changePage(i);
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
