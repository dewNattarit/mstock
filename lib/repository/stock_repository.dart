import 'dart:io';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

import '../constance/constance.dart';

mixin IStockRepository {
  Future<String?> getOrdersPath();
  Future<String?> getStockBalancPath();
  Future<bool> saveOrdersPath(String orderPath);
  Future<bool> saveStockPath(String stockBalancePath);
  Future<bool> saveResultPath(String resultPath);
  Future<SpreadsheetTable> getStockBalance(String filePath);
  Future<SpreadsheetTable> getOrders(String filePath);
  Future<File> exprotPredictStockExcel(List<int> fileBytes);
}

class StockRepository implements IStockRepository {
  @override
  Future<SpreadsheetTable> getStockBalance(String filePath) async {
    var bytes = File(filePath).readAsBytesSync();
    var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
    SpreadsheetTable tables = decoder.tables.values.first;
    return Future.value(tables);
  }

  @override
  Future<SpreadsheetTable> getOrders(String filePath) async {
    var bytes = File(filePath).readAsBytesSync();
    var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
    SpreadsheetTable tables = decoder.tables.values.first;
    return Future.value(tables);
  }

  @override
  Future<bool> saveOrdersPath(String orderPath) async {
    final prefs = await SharedPreferences.getInstance();
    return await Future.value(prefs.setString(Preferences.orders, orderPath));
  }

  @override
  Future<bool> saveStockPath(String stockBalancePath) async {
    final prefs = await SharedPreferences.getInstance();
    return await Future.value(
        prefs.setString(Preferences.stockBalance, stockBalancePath));
  }

  @override
  Future<bool> saveResultPath(String resultPath) async {
    final prefs = await SharedPreferences.getInstance();
    return await Future.value(prefs.setString(Preferences.result, resultPath));
  }

  @override
  Future<File> exprotPredictStockExcel(List<int> fileBytes) async {
    final prefs = await SharedPreferences.getInstance();
    String fileName = 'new_file.xlsx';
    final path = prefs.getString(Preferences.result);
    final filePath = '$path/$fileName';
    return File(join(filePath))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
  }

  @override
  Future<String?> getOrdersPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Preferences.orders);
  }

  @override
  Future<String?> getStockBalancPath() async {
    final prefs = await SharedPreferences.getInstance();
    final stockBalance = prefs.getString(Preferences.stockBalance);
    return stockBalance;
  }
}
