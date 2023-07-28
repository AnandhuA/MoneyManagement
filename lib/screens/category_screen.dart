import 'package:flutter/material.dart';
import 'package:money_management/screens/expense_screen.dart';
import 'package:money_management/screens/income_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(controller: tabController, tabs: const [
          Tab(
            text: "Income",
          ),
          Tab(
            text: "Expense",
          )
        ]),
        Expanded(
            child: TabBarView(
          controller: tabController,
          children: const [IncomeScreen(), ExpenseScreen()],
        )),
      ],
    );
  }
}
