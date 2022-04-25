import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/app/utils/util.dart';
import 'package:jogingu_advanced/data/shared_preference/target_pref.dart';
import 'package:jogingu_advanced/domain/entities/target.dart';

class EditTargetBloc extends BlocBase {
  final TargetPref pref;
  late final Target target;
  TimeOfDay? pickTime;

  EditTargetBloc({required this.pref});

  bool isChangedDisctance = false,
      isChangedCalo = false,
      isChangedStartAt = false,
      isChangedPlace = false,
      isChangedRecursive = false,
      isChangedNotifybefor = false,
      onChange = false;

  final TextEditingController distanceCtrl = TextEditingController(),
      caloCtrl = TextEditingController(),
      timeStartCtrl = TextEditingController(),
      placeCtrl = TextEditingController(),
      recursiveCtrl = TextEditingController(),
      notifyBeforeCtrl = TextEditingController();

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
    final now = DateTime.now();
    final newTarget = Target(
      distance: int.parse(distanceCtrl.text),
      calo: int.parse(caloCtrl.text),
      place: placeCtrl.text,
      timeStart: DateTime(now.year, now.month, now.day, pickTime?.hour ?? 0,
          pickTime?.minute ?? 0),
      recursive: int.parse(recursiveCtrl.text),
      notifyBefore: int.parse(notifyBeforeCtrl.text),
    );
    await pref.setTarget(newTarget);

    navigator.back();
	navigator.back();
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

  @override
  void onDispose() {
    // TODO: implement onDispose
  }

  @override
  void onInit() async {
    updateUiTarget();
  }
}
