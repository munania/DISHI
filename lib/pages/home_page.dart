import 'package:flutter/material.dart';
import 'package:dishi/pages/dashboard.dart';
import 'package:dishi/pages/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[Dashboard(), Search()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DISHI",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: _widgetOptions[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        selectedItemColor: const Color.fromRGBO(7, 33, 0, 100),
        currentIndex: currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            tooltip: "Search",
          ),
        ],
      ),
    );
  }
}
