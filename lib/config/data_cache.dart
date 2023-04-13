import 'dart:convert';
import 'package:async/async.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCache {
  Future<Result<void>> cacheData(String key, List<dynamic> data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, json.encode(data));
      return Result<void>.value(null);
    } catch (e) {
      return Result<void>.error(e);
    }
  }

  Future<Result<List<dynamic>?>> getCachedData(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString(key);

      if (jsonString != null) {
        return Result<List<dynamic>?>.value(json.decode(jsonString));
      }
      return Result<List<dynamic>?>.value(null);
    } catch (e) {
      return Result<List<dynamic>?>.error(e);
    }
  }
}
