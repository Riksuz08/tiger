import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  // Save integer value to SharedPreferences
  Future<void> saveIntToSharedPreferences(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

// Get integer value from SharedPreferences
  Future<int?> getIntFromSharedPreferences(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<void> saveBoolToSharedPreferences(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> getBoolFromSharedPreferences(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
