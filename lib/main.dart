import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/database_functions/transation_db.dart';
import 'package:money_management/database_model/category_model/category_model.dart';
import 'package:money_management/database_model/transation_mode/transation_model.dart';
import 'package:money_management/screens/Home_Screen.dart';
import 'package:money_management/screens/add_category_screen.dart';
import 'package:money_management/screens/add_transation_screen.dart';

import 'database_functions/category_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransationModelAdapter().typeId)) {
    Hive.registerAdapter(TransationModelAdapter());
  }
  CategoryDb().refreshUi();
  TransationDb().refresh();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoneyManagement',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      routes: {
        "AddTransation": (context) => AddTransation(),
        "AddCategory": (context) => AddCategory()
      },
    );
  }
}
