import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management/database_functions/category_db.dart';
import 'package:money_management/database_model/category_model/category_model.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeList,
      builder: (context, List<CategoryModel> newList, child) {
        return ListView.builder(
          itemBuilder: ((context, indext) {
            final cat = newList[indext];
            return Slidable(
              key: Key(cat.id),
              startActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (contex) {
                    CategoryDb.instance.delect(cat.id);
                  },
                  foregroundColor: Colors.red,
                  icon: Icons.delete,
                  label: "Delect",
                )
              ]),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                child: ListTile(
                  title: Text(cat.name),
                ),
              ),
            );
          }),
          itemCount: newList.length,
        );
      },
    );
  }
}
