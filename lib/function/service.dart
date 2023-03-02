import 'dart:io';

import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Services {
  static Future<dynamic> getInfo() async {
    try {
      //Directory? appDir = await getApplicationDocumentsDirectory();
      Directory? ex1Dir = await getExternalStorageDirectory();
      final path = ex1Dir?.path;
      final file = File('$path/phr.json');
      String response = await file.readAsString();
      // String response = await rootBundle.loadString('${file}');
      dynamic phr = await json.decode(response);
      // ignore: unrelated_type_equality_checks
      return phr;
    } catch (e) {
      return null;
    }
  }
}
