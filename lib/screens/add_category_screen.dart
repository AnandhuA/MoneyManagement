// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:money_management/database_functions/category_db.dart';
import 'package:money_management/database_model/category_model/category_model.dart';

class AddCategory extends StatefulWidget {
  AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  CategoryType selectedCategory = CategoryType.income;

  final texcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          foregroundColor: Colors.white,
          title: const Text("AddNewCategory"),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: texcontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter category name"),
            ),
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio(
                      value: CategoryType.income,
                      groupValue: selectedCategory,
                      onChanged: (newvalue) {
                        setState(() {
                          selectedCategory = CategoryType.income;
                        });
                      }),
                  const Text("Income")
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: CategoryType.expence,
                      groupValue: selectedCategory,
                      onChanged: (newvalue) {
                        setState(() {
                          selectedCategory = CategoryType.expence;
                        });
                      }),
                  const Text("Expanse")
                ],
              ),
            ],
          ),
          Container(
              width: 400,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  final name = texcontroller.text;
                  if (name.isEmpty) {
                    SnackBar snack =
                        const SnackBar(content: Text("Enter Category name"));
                    ScaffoldMessenger.of(context).showSnackBar(snack);
                    return;
                  }
                  final sample = CategoryModel(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      name: name,
                      type: selectedCategory);
                  CategoryDb().insertCategory(sample);
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.greenAccent)),
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ]));
  }
}
