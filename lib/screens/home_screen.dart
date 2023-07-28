import 'package:flutter/material.dart';
import 'package:money_management/screens/transation_screen.dart';

import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedindex = 0;
  final pages = [const TransationScreen(), const CategoryScreen()];
  void bottomNaviicontap(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.white,
        title: const Text("MoneyMangment"),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        foregroundColor: Colors.white,
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          if (selectedindex == 0) {
            Navigator.pushNamed(context, "AddTransation");
          } else {
            Navigator.pushNamed(context, "AddCategory");
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Category")
        ],
        currentIndex: selectedindex,
        onTap: bottomNaviicontap,
      ),
      body: pages[selectedindex],
    );
  }
}
