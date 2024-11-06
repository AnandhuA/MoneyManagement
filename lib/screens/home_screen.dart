import 'package:flutter/material.dart';
import 'package:money_management/widgets/empty_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Money Management')),
      body: emptyScreen(
        context: context,
        text1: "Show",
        size1: 16,
        text2: "Nothing",
        size2: 16,
        text3: "HomeScreen",
        size3: 22,
      ),
    );
  }
}
