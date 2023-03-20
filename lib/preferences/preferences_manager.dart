import 'package:flutter_application_1/preferences/preferences_keys.dart';
import 'package:flutter_application_1/preferences_utils.dart';

class PreferencesManager {
  Future<bool> clearData() async {
    return await PreferencesUtils.clearData();
  }

  Future<bool> setLocale(String data) async {
    return await PreferencesUtils.setString(PreferencesKeys.lang.name, data);
  }

  Future<String?> getLocale() async {
    return await PreferencesUtils.getString(PreferencesKeys.lang.name);
  }
}
