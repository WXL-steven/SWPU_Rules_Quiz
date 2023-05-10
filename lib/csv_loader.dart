import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

class CsvLoader {
  Future<List<List<dynamic>>> loadCsv(String path) async {
    String content = await rootBundle.loadString(path);
    List<List<dynamic>> csvData = const CsvToListConverter().convert(content);
    return csvData;
  }
}