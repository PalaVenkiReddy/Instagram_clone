import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // to contro the pages from bottomnavigationbar
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('this is homepage'),
      ),
      bottomNavigationBar:
          CupertinoTabBar(backgroundColor: Colors.black, items: [
        BottomNavigationBarItem(
            icon:
                Icon(Icons.home, color: page == 0 ? Colors.white : Colors.grey),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: page == 1 ? Colors.white : Colors.grey),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon:
                Icon(Icons.add, color: page == 2 ? Colors.white : Colors.grey),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
                color: page == 3 ? Colors.white : Colors.grey),
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: page == 4 ? Colors.white : Colors.grey),
            backgroundColor: Colors.white)
      ]),
    );
  }
}
