import 'package:flutter/material.dart';
import 'package:money_management/database_functions/category_db.dart';
import 'package:money_management/database_functions/transation_db.dart';
import 'package:money_management/database_model/category_model/category_model.dart';
import 'package:money_management/database_model/transation_mode/transation_model.dart';

class AddTransation extends StatefulWidget {
  const AddTransation({super.key});

  @override
  State<AddTransation> createState() => _AddTransationState();
}

class _AddTransationState extends State<AddTransation> {
  final puposeTextController = TextEditingController();
  final amountTextController = TextEditingController();
  DateTime? selectedDate;
  CategoryType selectedCategory = CategoryType.income;
  CategoryDb? categoryList;
  String? categoryId;
  CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.white,
        title: const Text("AddNewTransation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: puposeTextController,
              decoration: const InputDecoration(hintText: "Pupose"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: amountTextController,
              decoration: const InputDecoration(hintText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            TextButton.icon(
              onPressed: () async {
                final selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now());
                if (selectedDateTemp == null) {
                  return;
                } else {
                  setState(() {
                    selectedDate = selectedDateTemp;
                  });
                }
              },
              icon: const Icon(Icons.calendar_month),
              label: Text(selectedDate == null
                  ? "Select date"
                  : selectedDate.toString()),
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
                          categoryId = null;
                        });
                      },
                    ),
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
                          categoryId = null;
                        });
                      },
                    ),
                    const Text("Expanse")
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 5),
              child: DropdownButton(
                  hint: const Text("Select category"),
                  value: categoryId,
                  items: (selectedCategory == CategoryType.income
                          ? CategoryDb.instance.incomeList
                          : CategoryDb.instance.expenceList)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () => categoryModel = e,
                    );
                  }).toList(),
                  onChanged: (newvalue) {
                    setState(() {
                      categoryId = newvalue;
                    });
                  }),
            ),
            SizedBox(
              width: 360,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.greenAccent),
                  ),
                  onPressed: () {
                    addTransation();
                  },
                  child: const Text(
                    "Add Transation",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  addTransation() async {
    final purposText = puposeTextController.text;
    final amountText = amountTextController.text;
    if (purposText.isEmpty) {
      SnackBar snack = const SnackBar(content: Text("Enter purpose"));
      return ScaffoldMessenger.of(context).showSnackBar(snack);
    }
    if (amountText.isEmpty) {
      SnackBar snack = const SnackBar(content: Text("Enter amount"));
      return ScaffoldMessenger.of(context).showSnackBar(snack);
    }
    if (selectedDate == null) {
      SnackBar snack = const SnackBar(content: Text("Select date"));
      return ScaffoldMessenger.of(context).showSnackBar(snack);
    }
    if (categoryId == null) {
      SnackBar snack = const SnackBar(content: Text("Select Category"));
      return ScaffoldMessenger.of(context).showSnackBar(snack);
    }
    if (categoryModel == null) {
      SnackBar snack = const SnackBar(content: Text("Select Category"));
      return ScaffoldMessenger.of(context).showSnackBar(snack);
    }
    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }

    final model = TransationModel(
        purpose: purposText,
        amount: parsedAmount,
        category: categoryModel!,
        time: selectedDate!,
        type: selectedCategory);

    TransationDb.instance.insertTransation(model);
    Navigator.of(context).pop();
  }
}
