import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/database_model/transation_mode/transation_model.dart';

const CATEGORY_DB_NAME = "transation-database";

abstract class TransationDbFunction {
  Future<void> insertTransation(TransationModel value);
  Future<List<TransationModel>> getTransations();
  Future<void> delectTransation(String transationId);
}

class TransationDb implements TransationDbFunction {
  TransationDb.internal();
  static TransationDb instance = TransationDb.internal();

  factory TransationDb() {
    return instance;
  }

  ValueNotifier<List<TransationModel>> transationList = ValueNotifier([]);
  @override
  Future<void> insertTransation(TransationModel value) async {
    final transatioDb = await Hive.openBox<TransationModel>(CATEGORY_DB_NAME);
    transatioDb.put(value.id, value);
    refresh();
  }

  @override
  Future<List<TransationModel>> getTransations() async {
    final transatioDb = await Hive.openBox<TransationModel>(CATEGORY_DB_NAME);
    return transatioDb.values.toList();
  }

  Future<void> refresh() async {
    final transation = await getTransations();
    transation.sort((first, second) => second.time.compareTo(first.time));
    transationList.value.clear();
    Future.forEach(transation,
        (TransationModel newlist) => transationList.value.add(newlist));
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    transationList.notifyListeners();
  }

  @override
  Future<void> delectTransation(String transationId) async {
    final transatioDb = await Hive.openBox<TransationModel>(CATEGORY_DB_NAME);
    await transatioDb.delete(transationId);
    refresh();
  }
}
