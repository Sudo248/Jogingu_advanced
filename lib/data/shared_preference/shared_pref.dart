import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref? thisInstance;

  static SharedPref get I => instance;

  static SharedPref get instance {
    thisInstance ??= SharedPref._();
    return thisInstance!;
  }

  SharedPref._();

  final Future<SharedPreferences> _instance = SharedPreferences.getInstance();

  Future<bool> setInt(String key, int value) async {
    final pref = await _instance;
    return pref.setInt(key, value);
  }

  Future<int> getInt(String key, {int defaultInt = -1}) async {
    final pref = await _instance;
    return pref.getInt(key) ?? defaultInt;
  }

  Future<bool> setString(String key, String value) async {
    final pref = await _instance;
    return pref.setString(key, value);
  }

  Future<String> getString(String key, {String defaultString = "error"}) async {
    final pref = await _instance;
    return pref.getString(key) ?? defaultString;
  }

  Future<bool> setDouble(String key, double value) async {
    final pref = await _instance;
    return pref.setDouble(key, value);
  }

  Future<double> getDouble(String key, {double defaultDouble = -1.0}) async {
    final pref = await _instance;
    return pref.getDouble(key) ?? defaultDouble;
  }

  Future<bool> setBool(String key, bool value) async {
    final pref = await _instance;
    return pref.setBool(key, value);
  }

  Future<bool> getBool(String key, {bool defaultBool = false}) async {
    final pref = await _instance;
    return pref.getBool(key) ?? defaultBool;
  }

  Future<bool> setStringList(String key, List<String> value) async {
    final pref = await _instance;
    return pref.setStringList(key, value);
  }

  Future<List<String>> getStringList(String key,
      {List<String> defaultStirngList = const []}) async {
    final pref = await _instance;
    return pref.getStringList(key) ?? defaultStirngList;
  }
}
