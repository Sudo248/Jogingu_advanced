import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/service/notification_service.dart';
import 'package:jogingu_advanced/app/utils/util.dart';
import 'package:jogingu_advanced/data/shared_preference/target_pref.dart';
import 'package:jogingu_advanced/domain/entities/target.dart';

import '../../../../../../domain/common/constants.dart';

class EditTargetBloc extends BlocBase {
  final TargetPref pref;
  late final Target target;
  final NotificationService notificationService;
  TimeOfDay? pickTime;

  bool isChangedDisctance = false,
      isChangedCalo = false,
      isChangedStartAt = false,
      isChangedPlace = false,
      isChangedRecursive = false,
      isChangedNotifybefor = false,
      onChange = false;

  late final TextEditingController distanceCtrl,
      caloCtrl,
      timeStartCtrl,
      placeCtrl,
      recursiveCtrl,
      notifyBeforeCtrl;

  final notificationBeforFormKey = GlobalKey<FormState>();

  EditTargetBloc({
    required this.pref,
    required this.notificationService,
  }) {
    distanceCtrl = TextEditingController();
    caloCtrl = TextEditingController();
    timeStartCtrl = TextEditingController();
    placeCtrl = TextEditingController();
    recursiveCtrl = TextEditingController();
    notifyBeforeCtrl = TextEditingController();
  }

  Future<void> updateUiTarget() async {
    target = await pref.getTarget();
    distanceCtrl.text = "${target.distance}";
    caloCtrl.text = "${target.calo}";
    placeCtrl.text = target.place ?? "";
    recursiveCtrl.text = "${target.recursive}";
    notifyBeforeCtrl.text = "${target.notifyBefore}";
    pickTime = TimeOfDay.fromDateTime(target.timeStart ?? DateTime.now());
    timeStartCtrl.text = formatTimeOfDay(pickTime!);
    onListentChange();
  }

  Future<void> updateTimeStart(BuildContext context) async {
    timeStartCtrl.text = pickTime?.format(context) ?? "";
  }

  Future<void> saveTarget() async {
    if (notificationBeforFormKey.currentState!.validate()) {
      final now = DateTime.now();
      final newTarget = Target(
        distance: int.parse(distanceCtrl.text),
        calo: int.parse(caloCtrl.text),
        place: placeCtrl.text,
        timeStart: DateTime(
          now.year,
          now.month,
          now.day,
          pickTime?.hour ?? 0,
          pickTime?.minute ?? 0,
        ),
        recursive: int.parse(recursiveCtrl.text),
        notifyBefore: int.parse(notifyBeforeCtrl.text),
      );

      scheduleNotification(
        newTarget.timeStart!
            .subtract(Duration(minutes: newTarget.notifyBefore)),
        getContentNotification(newTarget),
      );
      await pref.setTarget(newTarget);

      navigator.back();
    }
  }

  Future<void> scheduleNotification(DateTime timeNotify, String content) async {
    Time scheduleTime = Time(
      timeNotify.hour,
      timeNotify.minute,
      timeNotify.second,
    );

    notificationService.scheduleNotificationDaily(
      id: Constants.channelIdNotificationDaily,
      title: "Target Today",
      body: content,
      time: scheduleTime,
    );
  }

  String getContentNotification(Target target) {
    String content =
        "You have a run in ${target.place} at ${target.timeStart?.hour}h ${target.timeStart?.minute}m";
    if (target.distance > 0 && target.calo > 0) {
      content += " with target ${target.distance} km and ${target.calo} calos.";
    } else if (target.distance > 0) {
      content += " with target ${target.distance} km.";
    } else if (target.calo > 0) {
      content += " with target ${target.calo} calos.";
    }
    return content;
  }

  void onListentChange() async {
    distanceCtrl.addListener(() {
      //   isChangedDisctance = target.distance != int.parse(distanceCtrl.text);
      onChange = true;
    });

    caloCtrl.addListener(() {
      //   isChangedCalo = target.calo != int.parse(caloCtrl.text);
      onChange = true;
    });

    timeStartCtrl.addListener(() {
      // isChangedStartAt = target.timeStart !=
      onChange = true;
    });

    placeCtrl.addListener(() {
      onChange = true;
    });

    recursiveCtrl.addListener(() {
      onChange = true;
    });

    notifyBeforeCtrl.addListener(() {
      onChange = true;
    });
  }

  String? validatorNotificationBefor(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (int.parse(value) > 60) {
      return "Not more than 60 minutes";
    }
    return null;
  }

  @override
  void onDispose() {
    // TODO: implement onDispose
  }

  @override
  void onInit() async {
    updateUiTarget();
  }
}
