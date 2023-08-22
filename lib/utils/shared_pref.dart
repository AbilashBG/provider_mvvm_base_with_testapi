import 'dart:ffi';

import 'package:mvvmbasic/utils/pref_keys.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocal {
  late SecureSharedPref _prefs;

  //SharedPreferencesLocal instance = SharedPreferencesLocal();

  Future<SharedPreferencesLocal> init() async {
    // Obtain shared preferences.
    _prefs = await SecureSharedPref.getInstance();
    return this;
  }

  void setString(PrefKeys prefKeys, String value) {
    _prefs.putString(prefKeys.name, value, isEncrypted: true);
  }

  void setInt(PrefKeys prefKeys, int value) {
    _prefs.putInt(prefKeys.name, value, isEncrypted: true);
  }

  void setDouble(PrefKeys prefKeys, double value) {
    _prefs.putDouble(prefKeys.name, value, isEncrypted: true);
  }

  void setBool(PrefKeys prefKeys, bool value) {
    _prefs.putBool(prefKeys.name, value, isEncrypted: true);
  }

  void setSet(PrefKeys prefKeys, List<String> value) {
    _prefs.putStringList(prefKeys.name, value, isEncrypted: true);
  }

  void setMap(PrefKeys prefKeys, Map<String, dynamic> value) {
    _prefs.putMap(prefKeys.name, value, isEncrypted: true);
  }

  Future<String> getString(PrefKeys prefKeys,
      {String defaultValue = ""}) async {
    return await _prefs.getString(prefKeys.name, isEncrypted: true) ??
        defaultValue;
  }

  Future<int> getInt(PrefKeys prefKeys, {int defaultValue = 0}) async {
    return await _prefs.getInt(prefKeys.name, isEncrypted: true) ??
        defaultValue;
  }

  Future<double> getDouble(PrefKeys prefKeys,
      {double defaultValue = 0.1}) async {
    return await _prefs.getDouble(prefKeys.name, isEncrypted: true) ??
        defaultValue;
  }

  Future<bool> getBool(PrefKeys prefKeys, {bool defaultValue = false}) async {
    return await _prefs.getBool(prefKeys.name, isEncrypted: true) ??
        defaultValue;
  }

  Future<List<String>> getSet(PrefKeys prefKeys) async {
    return await _prefs.getStringList(prefKeys.name, isEncrypted: true) ??
        [] as List<String>;
  }

  Future<Map<dynamic, dynamic>> getMap(PrefKeys prefKeys) async {

    return await _prefs.getMap(prefKeys.name,isEncrypted:true) ?? {};
  }
}
