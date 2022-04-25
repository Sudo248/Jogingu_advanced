import 'package:jogingu_advanced/domain/common/logger.dart';
import 'package:jogingu_advanced/domain/entities/target.dart';

import 'pref_keys.dart';
import 'shared_pref.dart';

class TargetPref {
  final SharedPref prefs = SharedPref.I;

  Future<bool> setTarget(Target target) async {
    prefs.setInt(PrefKeys.disctance, target.distance);

    prefs.setInt(PrefKeys.calo, target.calo);

    prefs.setString(PrefKeys.place, target.place ?? "");

    prefs.setInt(PrefKeys.recursive, target.recursive);

    prefs.setInt(
        PrefKeys.timeStart, target.timeStart?.millisecondsSinceEpoch ?? 0);

    await prefs.setInt(PrefKeys.notifyBefore, target.notifyBefore);
    Logger.success(message: "Save target");
    return Future.value(true);
  }

  Future<Target> getTarget() async {
    final disctance = prefs.getInt(PrefKeys.disctance, defaultInt: 0);
    final calo = prefs.getInt(PrefKeys.calo, defaultInt: 0);
    final place = prefs.getString(PrefKeys.place, defaultString: "");
    final recursive = prefs.getInt(PrefKeys.recursive, defaultInt: 0);
    final timeStart = prefs.getInt(PrefKeys.timeStart);
    final notifyBefore = prefs.getInt(PrefKeys.notifyBefore, defaultInt: 0);

    return Future.value(
      Target(
          distance: await disctance,
          calo: await calo,
          place: await place,
          recursive: await recursive,
          timeStart: DateTime.fromMicrosecondsSinceEpoch(await timeStart),
          notifyBefore: await notifyBefore),
    );
  }
}
