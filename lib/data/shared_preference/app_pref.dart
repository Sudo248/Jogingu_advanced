import 'package:jogingu_advanced/data/shared_preference/pref_keys.dart';

import 'shared_pref.dart';

class AppPref {
  final SharedPref prefs = SharedPref.I;

  Future<bool> setIsFirstOpenApp(bool isFirstOpenApp) async {
    return prefs.setBool(PrefKeys.isFirstOpenApp, isFirstOpenApp);
  }

  Future<bool> get isFirstOpenApp => prefs.getBool(PrefKeys.isFirstOpenApp);
}
