import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/database_model/category_model/category_model.dart';
part 'transation_model.g.dart';

@HiveType(typeId: 3)
class TransationModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  DateTime time;
  @HiveField(3)
  CategoryType type;
  @HiveField(4)
  CategoryModel category;
  @HiveField(5)
  String id = DateTime.now().microsecondsSinceEpoch.toString();

  TransationModel(
      {required this.purpose,
      required this.amount,
      required this.category,
      required this.time,
      required this.type});
}
