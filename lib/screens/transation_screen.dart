import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/database_functions/transation_db.dart';
import 'package:money_management/database_model/category_model/category_model.dart';

import '../database_model/transation_mode/transation_model.dart';

class TransationScreen extends StatelessWidget {
  const TransationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TransationDb().transationList,
        builder: ((context, List<TransationModel> newlist, child) {
          return ListView.builder(
              itemBuilder: ((context, indext) {
                final transation = newlist[indext];
                return Slidable(
                  key: Key(transation.id),
                  startActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (contex) {
                        TransationDb.instance.delectTransation(transation.id);
                      },
                      foregroundColor: Colors.red,
                      icon: Icons.delete,
                      label: "Delect",
                    )
                  ]),
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 45,
                        backgroundColor:
                            (transation.type == CategoryType.expence
                                ? Colors.red
                                : Colors.green),
                        child: Text(
                          parsedDate(transation.time),
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      title: Text("Rs.${transation.amount}"),
                      subtitle: Text(transation.purpose),
                    ),
                  ),
                );
              }),
              itemCount: newlist.length);
        }));
  }

  String parsedDate(DateTime time) {
    final date = DateFormat.MMMd().format(time);
    final split = date.split(" ");
    return " ${split.last}\n${split.first}";
  }
}
